#!/bin/bash
# Claude Code status line, derived from the zsh PROMPT in ~/.zshrc
# (crab emoji, custom truncated path, git branch, all in the original colors)

input=$(cat)
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')

# Mirrors _custom_path() from ~/.zshrc:
# - "~/Code/<project>"      -> "Code/<project>"
# - "~/Code/<project>/a/b"  -> "<project>/a/b" (depth <= 2)
# - deeper paths            -> "<project>/…/<second-last>/<last>"
custom_path() {
  local p="$cwd"
  if [[ "$p" =~ ^(.*)/Code/([^/]+)(/(.*))?$ ]]; then
    local project="${BASH_REMATCH[2]}"
    local rest="${BASH_REMATCH[4]}"
    if [[ -z "$rest" ]]; then
      echo "Code/$project"
    else
      IFS='/' read -ra parts <<< "$rest"
      local depth=${#parts[@]}
      if (( depth <= 2 )); then
        echo "$project/$rest"
      else
        echo "$project/…/${parts[-2]}/${parts[-1]}"
      fi
    fi
  else
    echo "${p/#$HOME/~}"
  fi
}

# Mirrors _git_info_truncated() from ~/.zshrc: current branch, truncated to 15 chars.
# Uses --no-optional-locks so this never blocks/races with other git commands.
git_branch_truncated() {
  local branch
  branch=$(git -C "$cwd" --no-optional-locks rev-parse --abbrev-ref HEAD 2>/dev/null)
  [[ -z "$branch" ]] && return
  if (( ${#branch} > 15 )); then
    echo "${branch:0:15}…"
  else
    echo "$branch"
  fi
}

# Formats a raw token count as e.g. "850", "42k", "1.2m".
format_tokens() {
  awk -v n="$1" 'BEGIN {
    if (n >= 1000000) {
      v = n / 1000000
      printf (v == int(v)) ? "%dm" : "%.1fm", v
    } else if (n >= 1000) {
      v = n / 1000
      printf (v == int(v)) ? "%dk" : "%.1fk", v
    } else {
      printf "%d", n
    }
  }'
}

# Builds a "42k/1m (4%)" style context-usage string from the statusline JSON,
# falling back to just a percentage, or nothing if no data is available yet.
context_usage() {
  local used total pct
  used=$(echo "$input" | jq -r '.context_window.total_input_tokens // empty')
  total=$(echo "$input" | jq -r '.context_window.context_window_size // empty')
  pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

  if [[ -n "$used" && -n "$total" && "$total" != "0" ]]; then
    if [[ -z "$pct" ]]; then
      pct=$(awk -v u="$used" -v t="$total" 'BEGIN { printf "%.0f", (u * 100) / t }')
    else
      pct=$(awk -v p="$pct" 'BEGIN { printf "%.0f", p }')
    fi
    echo "$(format_tokens "$used")/$(format_tokens "$total") (${pct}%)"
  elif [[ -n "$pct" ]]; then
    pct=$(awk -v p="$pct" 'BEGIN { printf "%.0f", p }')
    echo "${pct}%"
  fi
}

path_display=$(custom_path)
git_display=$(git_branch_truncated)
context_display=$(context_usage)

if [[ -n "$git_display" ]]; then
  printf '🦀 \033[34m%s\033[0m \033[35mgit:(\033[31m%s\033[0m\033[35m)\033[0m' "$path_display" "$git_display"
else
  printf '🦀 \033[34m%s\033[0m' "$path_display"
fi

if [[ -n "$context_display" ]]; then
  printf ' \033[97m%s\033[0m' "$context_display"
fi
