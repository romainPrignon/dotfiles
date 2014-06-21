if [ "x$__GIT_PROMPT_DIR" == "x" ]
then
  __GIT_PROMPT_DIR=~/.git-prompt
fi

# Default values for the appearance of the prompt. Configure at will.
GIT_PROMPT_PREFIX="["
GIT_PROMPT_SUFFIX="]"
GIT_PROMPT_SEPARATOR="|"
GIT_PROMPT_BRANCH="${BMagenta}"
GIT_PROMPT_STAGED="${BGreen}• "
GIT_PROMPT_CONFLICTS="${BRed}⬢ "
GIT_PROMPT_CHANGED="${BRed}± "
GIT_PROMPT_REMOTE=" "
GIT_PROMPT_UNTRACKED="…"
GIT_PROMPT_CLEAN="${BGreen}√"

if [[ $TERM == *xterm* ]]; then
    TERM_TITLE="\[\e]0;\u@\h:\w\a\]"
fi

if [ -n "$SSH_CLIENT" ]; then
    PROMPT_START="\n$BCyan\u$BWhite@$BCyan\h $BYellow\w$ResetColor"
else
    PROMPT_START="\n$BCyan\u $BYellow\w$ResetColor"
fi

if [ $(id -u) -eq 0 ]; then
    PROMPT_END=" $BRed\$ $ResetColor"
    else
    PROMPT_END=" $Bold\$ $ResetColor"
fi


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

        PS1="$PYTHON_VIRTUALENV$TERM_TITLE$PROMPT_START$STATUS$PROMPT_END"
    else
        PS1="$TERM_TITLE$PROMPT_START$PROMPT_END"
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
