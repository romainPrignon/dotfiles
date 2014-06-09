# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
# ca veut dire pas acces au alias dans les script ?
case $- in
    *i*) ;;
      *) return;;
esac

source ~/.bash_profile
source ~/.exports

if [ -f ~/.aliases ]; then
    . ~/.aliases
fi
source ~/.functions

source ~/.bash_prompt
