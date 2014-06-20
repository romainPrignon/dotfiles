# If not running interactively, don't do anything
# ca veut dire pas acces au alias dans les script ?
case $- in
    *i*) ;;
      *) return;;
esac

source ~/.bash_profile
source ~/.exports
source ~/.functions
if [ -f ~/.aliases ]; then
    . ~/.aliases
fi

source ~/.bash_prompt
