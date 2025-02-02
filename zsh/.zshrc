export PATH="$PATH:/usr/local/git/bin:/usr/local/bin"
export PATH="$PATH:/Users/gusryan/Documents/Code/useful_stuff/ExisKeycloak/tools/KeycloakConfiguration/KeycloakConfiguration/bin/Debug/net6.0"
export PATH="/usr/local/share/npm/bin:$PATH"

export GIT_CONFIG="~/.config/git/.gitconfig"

alias vi="nvim"
alias vim="nvim"
alias vi="nvim"
alias nb="f() { pbpaste | xargs -I % git checkout -b % develop-global && pbpaste | xargs git push --set-upstream origin };f"
alias zed="zed-preview ."

eval "$(zoxide init zsh)"

# Bind ctrl-r but not up arrow
eval "$(atuin init zsh --disable-up-arrow)"

# use eval arg to evaluate commmand and then enter interactive mode
if [[ $1 == eval ]]
then
    "$@"
set --
fi
