USER_DIR="/Users/gusryan"

BREW="/opt/homebrew/bin"
GIT="/usr/local/git/bin"
BIN="/usr/local/bin"
NPM="/usr/local/share/npm/bin"
PY="/opt/homebrew/opt/python@3.12/libexec/bin"
DOTNET="$USER_DIR/Documents/Code/useful_stuff/ExisKeycloak/tools/KeycloakConfiguration/KeycloakConfiguration/bin/Debug/net6.0"
GO="$USER_DIR/go/bin"
BUN="$USER_DIR/.bun/bin"
ANTIGRAVITY="$USER_DIR/.antigravity/antigravity/bin"
LOCAL_BIN="$HOME/.local/bin"

export PATH="$BREW:$PATH:$GIT:$BIN:$DOTNET:$NPM:$GO:$PY:$BUN:$ANTIGRAVITY:$LOCAL_BIN"

export XDG_CONFIG_HOME="$HOME/.config"

source "$XDG_CONFIG_HOME/zsh/.env"

export GIT_CONFIG_GLOBAL="$XDG_CONFIG_HOME/git/.gitconfig"

export DOTNET_ROOT=/usr/local/share/dotnet

alias g='git'
alias gb='git checkout '

alias vi='nvim'
alias vim='nvim'
alias o='zed .'

alias yeet='fn() { top -l 1 | grep $1 | awk "{print \$1}" | xargs kill -9 }; fn'
alias yn='yeet node'
alias fm="claude 'fix mergos'"

alias d='dotnet'
alias dr='dotnet run'
alias p='pnpm'

alias scriptos='jq .scripts package.json'
alias yp='fn() { lsof -ti "tcp:$1" | xargs kill -9 }; fn'
# on the bleeding edge
alias ls='lsd'

alias View='echo oops'

alias c='claude'
alias cu='brew upgrade claude-code@latest'
alias cr='claude -r'
alias claudo='claude'
alias mont='claude'
alias monty='claude'

alias ous='open $(user-secrets)'

alias apply_dotenv='export $(grep -v '^#' .env | xargs)'

alias pwdc='pwd | pbcopy'

alias ..='z ..'
alias ...='z ../..'
alias ....='z ../../..'

alias ff='fastfetch -l ~/.config/fastfetch/crab.txt'

alias rs='source $XDG_CONFIG_HOME/zsh/.zshrc'

alias pngclip="osascript -e 'set the clipboard to (the clipboard as «class PNGf»)'"

nvmInit() {
  export NVM_DIR="$HOME/.nvm"
    [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
    [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
}
alias nvm-init="nvmInit"
alias ni="nvmInit"

eval "$(zoxide init zsh)"

source ~/.config/atuin/atuin.zshrc

# use eval arg to evaluate commmand and then enter interactive mode
if [[ $1 == eval ]]
then
    "$@"
set --
fi

autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats '%b'

setopt PROMPT_SUBST
_git_info_truncated() {
  local info="${vcs_info_msg_0_}"
  if (( ${#info} > 15 )); then
    echo "${info:0:15}…"
  else
    echo "$info"
  fi
}
_custom_path() {
  if [[ "$PWD" =~ ^(.*)/Code/([^/]+)(/(.*))?$ ]]; then
    local project="${match[2]}"
    local rest="${match[4]}"
    if [[ -z "$rest" ]]; then
      echo "Code/$project"
    else
      local parts=(${(s:/:)rest})
      local depth=${#parts}
      if (( depth <= 2 )); then
        echo "$project/$rest"
      else
        echo "$project/…/${parts[-2]}/${parts[-1]}"
      fi
    fi
  else
    print -P '%2~'
  fi
}

PROMPT='🦀 %F{blue}$(_custom_path)%f %F{magenta}git:(%F{red}$(_git_info_truncated)%f%F{magenta}) %F{yellow}-> %F{white}'
