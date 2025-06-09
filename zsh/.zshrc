BIN="/usr/local/git/bin:/usr/local/bin"
DOTNET="/Users/gusryan/Documents/Code/useful_stuff/ExisKeycloak/tools/KeycloakConfiguration/KeycloakConfiguration/bin/Debug/net6.0"
NPM="/usr/local/share/npm/bin"
GO="/Users/gusryan/go/bin"

export PATH="$PATH:$BIN:$DOTNET:$NPM:$GO"

export XDG_CONFIG_HOME="/Users/gusryan/.config"
export GIT_CONFIG="$XDG_CONFIG_HOME/git/.gitconfig"

alias vi="nvim"
alias vim="nvim"
# yeet node
alias yn="f() { top -l 1 | grep node | awk '{print \$1}' | xargs kill -9 };f"
# on the bleeding edge
alias zed="zed-preview"

eval $(thefuck --alias)

eval "$(zoxide init zsh)"

source ~/.config/atuin/atuin.zshrc

# use eval arg to evaluate commmand and then enter interactive mode
if [[ $1 == eval ]]
then
    "$@"
set --
fi
