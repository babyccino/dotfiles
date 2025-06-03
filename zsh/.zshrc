export PATH="$PATH:/usr/local/git/bin:/usr/local/bin"
export PATH="$PATH:/Users/gusryan/Documents/Code/useful_stuff/ExisKeycloak/tools/KeycloakConfiguration/KeycloakConfiguration/bin/Debug/net6.0"
export PATH="$PATH:/usr/local/share/npm/bin"
export PATH="$PATH:/Users/gusryan/go/bin"

export GIT_CONFIG="~/.config/git/.gitconfig"
export XDG_CONFIG_HOME="~/.config"

alias vi="nvim"
alias vim="nvim"
alias vi="nvim"
alias yn="f() { top -l 1 | grep node | awk '{print \$1}' | xargs kill -9 };f"
alias zed="zed-preview"

eval $(thefuck --alias)

eval "$(zoxide init zsh)"

# Bind ctrl-r but not up arrow
eval "$(atuin init zsh --disable-up-arrow)"

# use eval arg to evaluate commmand and then enter interactive mode
if [[ $1 == eval ]]
then
    "$@"
set --
fi
