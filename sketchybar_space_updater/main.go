package main

import (
	"bytes"
	"fmt"
	"os"
	"os/exec"
	"reflect"
	"slices"
	"strings"
	"time"
	"unsafe"
)

type Workspace struct {
	name    string
	changed bool
	new     bool
	found   bool
	kv      map[string]bool
}
type Workspaces = map[string]*Workspace

var workspaces Workspaces = Workspaces{}

func reset() {
	for _, val := range workspaces {
		val.found = false
		val.new = false
		val.changed = false
		for appName := range val.kv {
			val.kv[appName] = false
		}
	}
}

var buf bytes.Buffer = *bytes.NewBuffer(make([]byte, 0, 1024))

func runAndLog(cmnd *exec.Cmd) error {
	cmnd.Stdout = &buf
	cmnd.Stderr = &buf
	err := cmnd.Run()

	if err == nil {
		return nil
	}

	fmt.Fprintf(
		os.Stderr,
		"err running %s\n\n%s\n\n%v",
		strings.Join(cmnd.Args, " "),
		string(buf.Bytes()),
		err,
	)

	os.Exit(1)
	return err
}

func newWorkspace(name string) *Workspace {
	return &Workspace{name: name, changed: false, new: true, found: false, kv: map[string]bool{}}
}

const idPrefix = "space."

func (workspace *Workspace) getId() string {
	return idPrefix + workspace.name
}

func (workspace *Workspace) getLabelAndUpdate() string {
	label := ""
	first := true
	for key, val := range workspace.kv {
		if val {
			if first {
				label += IconMap(key)
			} else {
				label += " " + IconMap(key)
			}
		} else {
			delete(workspace.kv, key)
		}
	}
	return label
}

func (workspace *Workspace) label() string {
	label := ""
	for key, val := range workspace.kv {
		if val {
			label += " " + key
		}
	}
	return label
}

func (workspace *Workspace) update() {
	for key, val := range workspace.kv {
		if !val {
			delete(workspace.kv, key)
		}
	}
}

func addWorkspace(workspace *Workspace) {
	label := workspace.getLabelAndUpdate()
	id := workspace.getId()
	cmnd := exec.Command(
		"sketchybar",
		"--add", "item", id,
		"left",
		"--subscribe", id, "aerospace_workspace_change",
		"--set", id,
		"background.corner_radius=5",
		"background.border_width=0",
		"background.padding_right=2",
		"background.padding_left=2",
		"icon.font=SF Pro:Bold:12.0",
		fmt.Sprintf("icon=%s", workspace.name),
		"label.font=sketchybar-app-font:Regular:15.0",
		fmt.Sprintf("label=%s", label),
		fmt.Sprintf("script=~/.config/sketchybar/plugins/aerospace.sh %s", id),
	)

	err := runAndLog(cmnd)
	if err != nil {
		return
	}
}

func setWorkspace(workspace *Workspace) {
	label := workspace.getLabelAndUpdate()
	cmnd := exec.Command(
		"sketchybar",
		"--set",
		workspace.getId(),
		"background.border_width=0",
		"label.drawing=on",
		fmt.Sprintf("label=%s", label),
	)

	err := runAndLog(cmnd)
	if err != nil {
		return
	}
}

func removeWorkspace(workspace *Workspace) {
	cmnd := exec.Command(
		"sketchybar",
		"--remove",
		workspace.getId(),
	)

	err := runAndLog(cmnd)
	if err != nil {
		return
	}
}

func nonWhitespace(char byte) bool { return char != ' ' }

func loop() {
	cmnd := exec.Command("aerospace", "list-windows", "--all", "--format", "%{workspace}\\%{app-name}")
	out, err := cmnd.Output()
	if err != nil {
		fmt.Fprintf(
			os.Stderr,
			"err running %s\n\n%s\n\n%v",
			strings.Join(cmnd.Args, " "),
			string(out),
			err,
		)
		os.Exit(1)
		return
	}

	for {
		slashIndex := slices.Index(out, '\\')
		if slashIndex == -1 {
			if slices.ContainsFunc(out, nonWhitespace) {
				fmt.Fprintf(
					os.Stderr,
					"no \\ found",
				)
				os.Exit(-1)
				return
			}
			break
		}

		workspaceName := string(out[:slashIndex])
		workspace, found := workspaces[workspaceName]
		if !found {
			workspace = newWorkspace(workspaceName)
			workspaces[workspaceName] = workspace
		}
		workspace.found = true

		newIndex := slices.Index(out, '\n')
		shouldBreak := newIndex == -1
		if shouldBreak {
			newIndex = len(out) - 1
		}

		appName := string(out[slashIndex+1 : newIndex])
		_, found = workspace.kv[appName]
		if !found {
			workspace.changed = true
		}
		workspace.kv[appName] = true

		if shouldBreak || newIndex == len(out)-1 {
			break
		}

		out = out[newIndex+1:]
	}

	// todo add all the set commands to one command
	for key, val := range workspaces {
		if val.new {
			addWorkspace(val)
			continue
		}
		if val.changed {
			setWorkspace(val)
			continue
		}
		if !val.found {
			removeWorkspace(val)
			delete(workspaces, key)
			continue
		}

		for _, keep := range val.kv {
			if !keep {
				setWorkspace(val)
				break
			}
		}
	}

}

func SetProcessName(name string) error {
	argv0str := (*reflect.StringHeader)(unsafe.Pointer(&os.Args[0]))
	argv0 := (*[1 << 30]byte)(unsafe.Pointer(argv0str.Data))[:argv0str.Len]

	n := copy(argv0, name)
	if n < len(argv0) {
		argv0[n] = 0
	}

	return nil
}

func main() {
	SetProcessName("aerospace-bar")

	for {
		loop()
		reset()
		time.Sleep(time.Millisecond * 50)
	}
}
