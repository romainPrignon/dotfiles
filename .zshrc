# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# theme to load in ~/.oh-my-zsh/themes/
ZSH_THEME="lukerandall"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd.mm.yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# plugins in ~/.oh-my-zsh/plugins/
# Custom plugins ~/.oh-my-zsh/custom/plugins/
plugins=(git bower composer docker npm symfony2 z zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh



# include aliases
if [ -f "$HOME/.aliases" ]; then
    . "$HOME/.aliases"
fi

# include functions
if [ -f "$HOME/.functions" ]; then
    . "$HOME/.functions"
fi

# include key-bindings
if [ -f "$HOME/.zsh/.key-bindings" ]; then
    . "$HOME/.zsh/.key-bindings"
fi

# include zsh_prompt
if [ -f "$HOME/.zsh/.zsh_prompt" ]; then
    . "$HOME/.zsh/.zsh_prompt"
fi
