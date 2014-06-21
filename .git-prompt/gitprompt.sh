if [ "x$__GIT_PROMPT_DIR" == "x" ]
then
  __GIT_PROMPT_DIR=~/.git-prompt
fi

# Default values for the appearance of the prompt. Configure at will.
GIT_PROMPT_PREFIX="["
GIT_PROMPT_SUFFIX="]"
GIT_PROMPT_SEPARATOR="|"
GIT_PROMPT_STAGED="$BGreen•$ResetColor "
GIT_PROMPT_CONFLICTS="$BRed⬢$ResetColor "
GIT_PROMPT_CHANGED="$BRed±$ResetColor "
GIT_PROMPT_REMOTE=" "
GIT_PROMPT_UNTRACKED="…"
GIT_PROMPT_CLEAN="$BGreen√$ResetColor"

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

    if [ -n "$__CURRENT_GIT_STATUS" ]; then
	  STATUS=" $GIT_PROMPT_PREFIX$GIT_BRANCH"

	  if [ -n "$GIT_REMOTE" ]; then
		  STATUS="$STATUS$GIT_PROMPT_REMOTE$GIT_REMOTE"
	  fi

	  STATUS="$STATUS$GIT_PROMPT_SEPARATOR"
	  if [ "$GIT_STAGED" -ne "0" ]; then
		  STATUS="$STATUS$GIT_PROMPT_STAGED$GIT_STAGED"
	  fi

	  if [ "$GIT_CONFLICTS" -ne "0" ]; then
		  STATUS="$STATUS$GIT_PROMPT_CONFLICTS$GIT_CONFLICTS "
	  fi
	  if [ "$GIT_CHANGED" -ne "0" ]; then
		  STATUS="$STATUS$GIT_PROMPT_CHANGED$GIT_CHANGED"
	  fi
	  if [ "$GIT_UNTRACKED" -ne "0" ]; then
		  STATUS="$STATUS$GIT_PROMPT_UNTRACKED$GIT_UNTRACKED"
	  fi
	  if [ "$GIT_CLEAN" -eq "1" ]; then
		  STATUS="$STATUS$GIT_PROMPT_CLEAN"
	  fi
	  STATUS="$STATUS$GIT_PROMPT_SUFFIX"

      echo "$STATUS"
	fi
}
