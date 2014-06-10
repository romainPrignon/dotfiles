if [ "x$__GIT_PROMPT_DIR" == "x" ]
then
  __GIT_PROMPT_DIR=~/.bash
fi

# Colors
# Reset
ResetColor="\[\033[0m\]"       # Text Reset

# Regular Colors
Black="\[\033[0;30m\]"        # Black
Red="\[\033[0;31m\]"          # Red
Green="\[\033[0;32m\]"        # Green
Yellow="\[\033[0;33m\]"       # Yellow
Blue="\[\033[0;34m\]"         # Blue
Purple="\[\033[0;35m\]"       # Purple
Cyan="\[\033[0;36m\]"         # Cyan
White="\[\033[0;37m\]"        # White

# Bold
BBlack="\[\033[1;30m\]"       # Black
BRed="\[\033[1;31m\]"         # Red
BGreen="\[\033[1;32m\]"       # Green
BYellow="\[\033[1;33m\]"      # Yellow
BBlue="\[\033[1;34m\]"        # Blue
BPurple="\[\033[1;35m\]"      # Purple
BCyan="\[\033[1;36m\]"        # Cyan
BWhite="\[\033[1;37m\]"       # White

# High Intensty
IBlack="\[\033[0;90m\]"       # Black
IRed="\[\033[0;91m\]"         # Red
IGreen="\[\033[0;92m\]"       # Green
IYellow="\[\033[0;93m\]"      # Yellow
IBlue="\[\033[0;94m\]"        # Blue
IPurple="\[\033[0;95m\]"      # Purple
ICyan="\[\033[0;96m\]"        # Cyan
IWhite="\[\033[0;97m\]"       # White

# Bold High Intensty
BIBlack="\[\033[1;90m\]"      # Black
BIRed="\[\033[1;91m\]"        # Red
BIGreen="\[\033[1;92m\]"      # Green
BIYellow="\[\033[1;93m\]"     # Yellow
BIBlue="\[\033[1;94m\]"       # Blue
BIPurple="\[\033[1;95m\]"     # Purple
BICyan="\[\033[1;96m\]"       # Cyan
BIWhite="\[\033[1;97m\]"      # White

# Various variables you might want for your PS1 prompt instead
Time12a="\@"
PathShort="\w"

# Default values for the appearance of the prompt. Configure at will.
GIT_PROMPT_PREFIX="["
GIT_PROMPT_SUFFIX="]"
GIT_PROMPT_SEPARATOR="|"
GIT_PROMPT_BRANCH="${BMagenta}"
GIT_PROMPT_STAGED="${BRed}• "
GIT_PROMPT_CONFLICTS="${BRed}■ "
GIT_PROMPT_CHANGED="${BCyan}± "
GIT_PROMPT_REMOTE=" "
GIT_PROMPT_UNTRACKED="…"
GIT_PROMPT_CLEAN="${BGreen}√"

PROMPT_START="$Yellow$PathShort$ResetColor"
PROMPT_END=" $ "


function update_current_git_vars() {
    unset __CURRENT_GIT_STATUS
    local gitstatus="${__GIT_PROMPT_DIR}/gitstatus.py"
    
    _GIT_STATUS=$(python "$gitstatus")
    __CURRENT_GIT_STATUS=($_GIT_STATUS)
	GIT_BRANCH=${__CURRENT_GIT_STATUS[0]}
	GIT_REMOTE=${__CURRENT_GIT_STATUS[1]}
    if [[ "." == "$GIT_REMOTE" ]]; then
		unset GIT_REMOTE
	fi
	GIT_STAGED=${__CURRENT_GIT_STATUS[2]}
	GIT_CONFLICTS=${__CURRENT_GIT_STATUS[3]}
	GIT_CHANGED=${__CURRENT_GIT_STATUS[4]}
	GIT_UNTRACKED=${__CURRENT_GIT_STATUS[5]}
	GIT_CLEAN=${__CURRENT_GIT_STATUS[6]}
}

function setGitPrompt() {
	update_current_git_vars
	set_virtualenv

	if [ -n "$__CURRENT_GIT_STATUS" ]; then
	  STATUS=" $GIT_PROMPT_PREFIX$GIT_PROMPT_BRANCH$GIT_BRANCH$ResetColor"

	  if [ -n "$GIT_REMOTE" ]; then
		  STATUS="$STATUS$GIT_PROMPT_REMOTE$GIT_REMOTE$ResetColor"
	  fi

	  STATUS="$STATUS$GIT_PROMPT_SEPARATOR"
	  if [ "$GIT_STAGED" -ne "0" ]; then
		  STATUS="$STATUS$GIT_PROMPT_STAGED$GIT_STAGED$ResetColor"
	  fi

	  if [ "$GIT_CONFLICTS" -ne "0" ]; then
		  STATUS="$STATUS$GIT_PROMPT_CONFLICTS$GIT_CONFLICTS$ResetColor "
	  fi
	  if [ "$GIT_CHANGED" -ne "0" ]; then
		  STATUS="$STATUS$GIT_PROMPT_CHANGED$GIT_CHANGED$ResetColor"
	  fi
	  if [ "$GIT_UNTRACKED" -ne "0" ]; then
		  STATUS="$STATUS$GIT_PROMPT_UNTRACKED$GIT_UNTRACKED$ResetColor"
	  fi
	  if [ "$GIT_CLEAN" -eq "1" ]; then
		  STATUS="$STATUS$GIT_PROMPT_CLEAN"
	  fi
	  STATUS="$STATUS$ResetColor$GIT_PROMPT_SUFFIX"

	  PS1="$PYTHON_VIRTUALENV$PROMPT_START$STATUS$PROMPT_END"
	else
	  PS1="$PROMPT_START$PROMPT_END"
	fi
}

# Determine active Python virtualenv details.
function set_virtualenv () {
  if test -z "$VIRTUAL_ENV" ; then
      PYTHON_VIRTUALENV=""
  else
      PYTHON_VIRTUALENV="${BLUE}(`basename \"$VIRTUAL_ENV\"`)${ResetColor} "
  fi
}

PROMPT_COMMAND=setGitPrompt
