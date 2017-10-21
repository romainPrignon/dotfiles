source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-git-prompt/zshrc.sh
source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh

# env
if [ -f "$HOME/.exports_linux" ]; then
    source "$HOME/.exports_linux"
fi

# alias and func
if [ -f "$HOME/.aliases" ]; then
    . "$HOME/.aliases"
fi

if [ -f "$HOME/.functions" ]; then
    . "$HOME/.functions"
fi

# include partner
if [ -f "$HOME/.m6rc" ]; then
    . "$HOME/.m6rc"
fi

if [ -f "$HOME/.llsrc" ]; then
    . "$HOME/.llsrc"
fi

if [ -f "$HOME/.yproxrc" ]; then
    . "$HOME/.yproxrc"
fi

# bootstrap
autoload -U promptinit && promptinit
autoload -U colors && colors
autoload -U compinit && compinit

# history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
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
zle -N history-fzf
bindkey '^r' history-fzf

## ctrl+right
bindkey '\e[1;5C' forward-word
## ctrl+left
bindkey '\e[1;5D' backward-word

# external

## n
export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"

## qfc
[[ -s "$HOME/.qfc/bin/qfc.sh" ]] && source "$HOME/.qfc/bin/qfc.sh"

## fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

## enhancd
export ENHANCD_COMMAND=ecd
export ENHANCD_DISABLE_DOT=1
[ -f ~/.enhancd/init.sh ] && source ~/.enhancd/init.sh


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
