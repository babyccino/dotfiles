package main

import (
	"bytes"
	"fmt"
	"log/slog"
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
	apps    map[string]bool
}
type Workspaces = map[string]*Workspace

var workspaces Workspaces = Workspaces{}

func reset() {
	for _, val := range workspaces {
		val.found = false
		val.new = false
		val.changed = false
		for appName := range val.apps {
			val.apps[appName] = false
		}
	}
}

var buf bytes.Buffer = *bytes.NewBuffer(make([]byte, 0, 1024))

func runAndLog(cmnd *exec.Cmd) error {
	cmnd.Stdout = &buf
	cmnd.Stderr = &buf

	err := cmnd.Run()
	if err == nil {
		if buf.Len() != 0 {
			slog.Error(
				"sketchybar cmd error",
				slog.String("stdout", string(buf.Bytes())),
			)
		}
		buf.Reset()
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
	return &Workspace{
		name:    name,
		changed: false,
		new:     true,
		found:   false,
		apps:    map[string]bool{},
	}
}

const idPrefix = "space."

func (workspace *Workspace) getId() string {
	return idPrefix + workspace.name
}

func (workspace *Workspace) getLabelAndUpdate() string {
	label := ""
	first := true
	for key, val := range workspace.apps {
		if val {
			if first {
				label += IconMap(key)
				first = false
			} else {
				label += " " + IconMap(key)
			}
		} else {
			delete(workspace.apps, key)
		}
	}
	return label
}

func (workspace *Workspace) label() string {
	label := ""
	for key, val := range workspace.apps {
		if val {
			label += " " + key
		}
	}
	return label
}

func (workspace *Workspace) update() {
	for key, val := range workspace.apps {
		if !val {
			delete(workspace.apps, key)
		}
	}
}

func (workspace *Workspace) getAddWorkspaceArgs(args *[]string) {
	label := workspace.getLabelAndUpdate()
	id := workspace.getId()
	*args = append(*args,
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
}

func (workspace *Workspace) getSetWorkspaceArgs(args *[]string) {
	label := workspace.getLabelAndUpdate()
	*args = append(*args,
		"--set",
		workspace.getId(),
		"background.border_width=0",
		"label.drawing=on",
		fmt.Sprintf("label=%s", label),
	)
}

func (workspace *Workspace) getRemoveWorkspaceArgs(args *[]string) {
	*args = append(*args,
		"--remove",
		workspace.getId(),
	)
}

func nonWhitespace(char byte) bool { return char != ' ' }

const aerospace = "aerospace"
const sketchybar = "sketchybar"

func loop() {
	cmnd := exec.Command(aerospace, "list-windows", "--all", "--format", "%{workspace}\\%{app-name}")
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
		_, found = workspace.apps[appName]
		if !found {
			workspace.changed = true
		}
		workspace.apps[appName] = true

		if shouldBreak || newIndex == len(out)-1 {
			break
		}

		out = out[newIndex+1:]
	}

	// todo add all the set commands to one command
	args := make([]string, 0)
	for key, workspace := range workspaces {
		if workspace.new {
			slog.Info("adding workspace", slog.String("workspace", workspace.getId()))
			workspace.getAddWorkspaceArgs(&args)
			continue
		}
		if workspace.changed {
			slog.Info("updating workspace", slog.String("workspace", workspace.getId()))
			workspace.getSetWorkspaceArgs(&args)
			continue
		}
		if !workspace.found {
			slog.Info("removing workspace", slog.String("workspace", workspace.getId()))
			workspace.getRemoveWorkspaceArgs(&args)
			delete(workspaces, key)
			continue
		}

		for _, keep := range workspace.apps {
			if !keep {
				slog.Info("updating workspace", slog.String("workspace", workspace.getId()))
				workspace.getSetWorkspaceArgs(&args)
				break
			}
		}
	}

	if len(args) > 0 {
		cmnd = exec.Command(
			sketchybar,
			args...,
		)

		err = runAndLog(cmnd)
		if err != nil {
			return
		}

		args = args[:0]
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
