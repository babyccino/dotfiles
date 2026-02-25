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

export PATH="$BREW:$PATH:$GIT:$BIN:$DOTNET:$NPM:$GO:$PY:$BUN:$ANTIGRAVITY"

export XDG_CONFIG_HOME="$HOME/.config"

export GIT_CONFIG_GLOBAL="$XDG_CONFIG_HOME/git/.gitconfig"

export TEST_CONNECTION_TEMPLATE='Server=192.168.0.139,1433;Database={0};Integrated Security=False;User Id=gus2;Password=newpass;MultipleActiveResultSets=True;Encrypt=False'

# benjo
export TEST_CONNECTION_TEMPLATE='Server=10.0.100.58,1433;Database={0};Integrated Security=False;User Id=sa;Password=Password1;MultipleActiveResultSets=True;Encrypt=False'

alias g='git'
alias vi='nvim'
alias vim='nvim'
alias yeet='fn() { top -l 1 | grep $1 | awk "{print \$1}" | xargs kill -9 }; fn'
alias yn='yeet node'
alias d='dotnet'
alias p='pnpm'
alias yp='fn() { lsof -ti "tcp:$1" | xargs kill -9 }; fn'
# on the bleeding edge
alias ls='lsd'

alias ous='open $(user-secrets)'

alias apply_dotenv='export $(grep -v '^#' .env | xargs)'

alias ..='z ..'
alias ...='z ../..'

alias ff='fastfetch -l ~/.config/fastfetch/crab.txt'

alias rs='source $XDG_CONFIG_HOME/zsh/.zshrc'

nvmInit() {
  export NVM_DIR="$HOME/.nvm"
    [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
    [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
}
alias nvm-init="nvmInit"

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
PROMPT='🦀 %F{blue}%2~%f %F{magenta}git:(%F{red}${vcs_info_msg_0_}%f%F{magenta}) %F{yellow}-> %F{white}'
