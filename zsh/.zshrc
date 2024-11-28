export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

export PATH="$HOME/bin:${PATH}"
export PATH="$PATH:/usr/local/git/bin:/usr/local/bin"
export PATH="$PATH:/Users/gusryan/Documents/Code/useful_stuff/ExisKeycloak/tools/KeycloakConfiguration/KeycloakConfiguration/bin/Debug/net6.0"

# node
export PATH="/usr/local/share/npm/bin:$PATH"

# open neovim with vi command
alias vim="nvim"
alias vi="nvim"
alias hello="nvim"

# zoxide -> z
eval "$(zoxide init zsh)"

# Bind ctrl-r but not up arrow
eval "$(atuin init zsh --disable-up-arrow)"

# use eval arg to evaluate commmand and then enter interactive mode
if [[ $1 == eval ]]
then
    "$@"
set --
fi
