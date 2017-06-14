case $- in
    *i*) ;;
      *) return;;
esac

# include aliases
if [ -f "$HOME/.aliases" ]; then
    . "$HOME/.aliases"
fi

# include functions
if [ -f "$HOME/.functions" ]; then
    . "$HOME/.functions"
fi

# include env specific var
if [ -f "$HOME/.exports_linux" ]; then
    . "$HOME/.exports_linux"
fi
if [ -f "$HOME/.exports_windows" ]; then
    . "$HOME/.exports_windows"
fi

# include completion
if [ -f "$HOME/bash_completion.d/npm" ]; then
    . "$HOME/bash_completion.d/npm"
fi

#######################################

# Avoid duplicate entries
HISTCONTROL="erasedups:ignoreboth:ignorespace"

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=500000
HISTFILESIZE=100000

# Useful timestamp format
HISTTIMEFORMAT='%F %T '

# Don't record some commands
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

export PROMPT_COMMAND='history -a; history -n'

#######################################

# include prompt
GIT_PROMPT_THEME=Single_line_Ubuntu_Romain
GIT_PROMPT_FETCH_REMOTE_STATUS=0
GIT_PROMPT_IGNORE_STASH=1
source ~/.bash-git-prompt/gitprompt.sh

#######################################

# append to the history file, don't overwrite it
shopt -s histappend

# Save multi-line commands as one command
shopt -s cmdhist

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Correct spelling errors during tab-completion
shopt -s dirspell

# Prepend cd to directory names automatically
shopt -s autocd

# This defines where cd looks for targets
# Add the directories you want to have fast access to, separated by colon
# Ex: CDPATH=".:~:~/projects" will look for targets in the current working directory, in home and in the ~/projects folder
CDPATH=".:~/workspace"

# Turn on recursive globbing (enables ** to recurse all directories)
shopt -s globstar 2> /dev/null

# Prevent file overwrite on stdout redirection
set -o noclobber

#######################################

# starting command
if [ -z "$SSH_AUTH_SOCK" ] ; then
  eval `ssh-agent -s` > /dev/null
  ssh-add
fi

# n
export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

# qfc
[[ -s "$HOME/.qfc/bin/qfc.sh" ]] && source "$HOME/.qfc/bin/qfc.sh" # Added by qfc (see https://github.com/pindexis/qfc)

# hstr
export HH_CONFIG=hicolor
if [[ $- =~ .*i.* ]]; then bind '"\C-r": "\C-a hh -- \C-j"'; fi

###############################################################################

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

###############################################################################

# include partner
if [ -f "$HOME/.m6rc" ]; then
    . "$HOME/.m6rc"
fi

if [ -f "$HOME/.llsrc" ]; then
    . "$HOME/.llsrc"
fi
