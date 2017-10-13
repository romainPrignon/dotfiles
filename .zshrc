setopt noautomenu

if [ -f "$HOME/.exports_linux" ]; then
    source "$HOME/.exports_linux"
fi

HISTFILE=~/.zsh_history         # where to store zsh config
HISTSIZE=10000                  # big history
SAVEHIST=10000                  # big history
setopt append_history           # append
setopt hist_ignore_all_dups     # no duplicate
setopt inc_append_history       # add commands as they are typed, don't wait until shell exit

