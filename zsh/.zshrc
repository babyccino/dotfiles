echo 'initializing zshrc...'

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

BREW="/opt/homebrew/bin"
BIN="/usr/local/git/bin:/usr/local/bin"
DOTNET="/Users/gusryan/Documents/Code/useful_stuff/ExisKeycloak/tools/KeycloakConfiguration/KeycloakConfiguration/bin/Debug/net6.0"
NPM="/usr/local/share/npm/bin"
GO="/Users/gusryan/go/bin"

export PATH="$BREW:$PATH:$BIN:$DOTNET:$NPM:$GO"

export XDG_CONFIG_HOME="$HOME/.config"

export GIT_CONFIG_GLOBAL="$XDG_CONFIG_HOME/git/.gitconfig"

alias g='git'
alias vi='nvim'
alias vim='nvim'
alias yeet='fn() { top -l 1 | grep $1 | awk "{print \$1}" | xargs kill -9 }; fn'
alias yn='yeet node'
alias yp='fn() { lsof -ti "tcp:$1" | xargs kill -9 }; fn'
# on the bleeding edge
alias ls='lsd'
alias yd='yarn dev'
alias ydf='yarn dev:fresh'

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

# source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# source ~/.config/p10k/.p10k.zsh

# Added by Antigravity
export PATH="/Users/gusryan/.antigravity/antigravity/bin:$PATH"
