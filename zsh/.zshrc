export SHELL="/bin/zsh"

# alias and func
if [ -f "$HOME/.aliases" ]; then
    . "$HOME/.aliases"
fi

if [ -f "$HOME/.functions" ]; then
    . "$HOME/.functions"
fi

# include partner
for f in $HOME/.rc/*.rc; do source $f; done

# bootstrap
autoload -U promptinit && promptinit
autoload -U colors && colors
autoload -U compinit && compinit
autoload -U edit-command-line

# plugins 
source ~/.zsh/fzf-tab/fzf-tab.plugin.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-git-prompt/zshrc.sh
source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh

# history
HISTFILE=~/.zsh_history
setopt append_history
setopt inc_append_history
setopt hist_ignore_all_dups
alias history='history -i'

# prompt
ZSH_THEME_GIT_PROMPT_PREFIX="["
ZSH_THEME_GIT_PROMPT_SUFFIX="]"
ZSH_THEME_GIT_PROMPT_SEPARATOR=" | "
ZSH_THEME_GIT_PROMPT_BRANCH=""
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg_bold[green]%}%{•%G%}"
ZSH_THEME_GIT_PROMPT_CONFLICTS="%{$fg_bold[red]%}%{x%G%}"
ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg_bold[blue]%}%{±%G%}"
ZSH_THEME_GIT_PROMPT_BEHIND="%{↓·%G%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{↑·%G%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[cyan]%}%{…%G%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}%{✔%G%}"

## prompt title
precmd () {print -Pn "\e]0;# %2~\a"}

PROMPT='
%(?.%{$fg[green]%}✔%{$reset_color%}.%{$fg[red]%}✘%{$reset_color%}) %{$fg_bold[cyan]%}%n%{$reset_color%} %{$fg_bold[yellow]%}%2~%{$reset_color%}$(git_super_status) %{$fg_bold[white]%}#%{$reset_color%} '

# options
setopt noautomenu
setopt auto_cd
setopt correct
unsetopt beep

zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# keymapping

## ctrl+r
function history-fzf() {
  local tac

  if which tac > /dev/null; then
    tac="tac"
  else
    tac="tail -r"
  fi

  BUFFER=$(history -n 1 | eval $tac | fzf --query "$LBUFFER")
  CURSOR=$#BUFFER

  zle reset-prompt
}

# zle
zle -N history-fzf
zle -N edit-command-line

## ctrl+r
bindkey '^r' history-fzf
## ctrl+right
bindkey '\e[1;5C' forward-word
## ctrl+left
bindkey '\e[1;5D' backward-word
## ctrl+k
bindkey "^K" kill-whole-line
## ctrl+z
bindkey '^Z' backward-kill-word

## editor
bindkey '^u' edit-command-line

## always on top
bindkey -s '^m' '^l^j'

# 2 => `
if [[ $DISPLAY ]]; then
  xmodmap -e "keycode 49 = grave"
fi

# caps_lock => <>
if [[ $DISPLAY ]]; then
  xmodmap -e "keycode 66 = less greater"
fi

# external

## fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# asdf
[ -f $HOME/.asdf/asdf.sh ] && source $HOME/.asdf/asdf.sh

# autocomplete
[ -f $HOME/.zcompletions ] && source $HOME/.zcompletions

# kube
[ -f $HOME/.asdf/shims/kubectl ] && complete -o default -F __start_kubectl k

# broot
[ -f $HOME/.config/broot/launcher/bash/br ] && source /home/romainprignon/.config/broot/launcher/bash/br

# must be at the end
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main)
ZSH_HIGHLIGHT_STYLES[default]=none
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=white
ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=white,underline
ZSH_HIGHLIGHT_STYLES[alias]=fg=010
ZSH_HIGHLIGHT_STYLES[builtin]=fg=010
ZSH_HIGHLIGHT_STYLES[function]=fg=014
ZSH_HIGHLIGHT_STYLES[command]=fg=010
ZSH_HIGHLIGHT_STYLES[precommand]=fg=white
ZSH_HIGHLIGHT_STYLES[commandseparator]=none
ZSH_HIGHLIGHT_STYLES[path]=fg=003
ZSH_HIGHLIGHT_STYLES[path_pathseparator]=fg=white
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=011
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=011
ZSH_HIGHLIGHT_STYLES[assign]=fg=011

