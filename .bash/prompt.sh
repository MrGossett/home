__is_interactive_shell() {
  if [ -n "$SSH_CLIENT" ] && [ -n "$SSH_TTY" ]; then
    return 0
  elif [ -t 0 ] || [ -p /dev/stdin ]; then
    return 0
  else
    return 1
  fi
}

set_term() {
  # bail if this is not a TTY
  __is_interactive_shell || return 0

  # bail if TERM already supports 256 colors
  case "$TERM" in
    *"-256color")
      # we good fam
      ;;
    *)
      return 0
      ;;
  esac

  # find a 256-color term from the terminfo database
  search="/lib/terminfo"
  if [ "$(uname -s)" = "Darwin" ]; then
    search="/usr/share/terminfo"
  fi
  term="$(find $search -type f -name "*-256color" -exec basename {} \; | sort -r | head -n 1)"

  # if we found one, then export it as TERM
  [ -n "$term" ] && export TERM="$term"
}
set_term

prompt_command() {
  code=$? # capture exit code from last command for later use
  __is_interactive_shell || return 0

  # local vars for colors
  Reset="\[$(tput sgr0)\]"

  # newline after last command's output to kick off prompt
  ps1="\n"

  ### SHELLSTACK

  # Last Command indicator
  if [ $code -eq 0 ]; then
    ps1="$ps1\[$(tput setaf 2)\]✔"
  else
    ps1="$ps1\[$(tput setaf 1)\]✖"
  fi
  ps1="$ps1${Reset} "

  # Docker Machine name
  if [ -n "$DOCKER_MACHINE_NAME" ]; then
    ps1="$ps1\[$(tput setaf 12)\]dm:$DOCKER_MACHINE_NAME${Reset} "
  fi

  # AWS profile
  if [ -n "$AWS_PROFILE" ]; then
    ps1="$ps1\[$(tput setaf 130)\]aws:${AWS_PROFILE}${Reset} "
  fi

  ## git info
  # git branch
  if git rev-parse -q HEAD >/dev/null 2>&1; then
    branch=$(git rev-parse --abbrev-ref HEAD)
    upstream="$(git config --get "branch.$branch.remote" 2>/dev/null)"
    slug="$(git remote get-url --push "$upstream" 2>/dev/null)"
    slug=${slug#ssh://}
    slug=${slug#https://}
    slug=${slug#git@}
    slug=${slug#*github.com}
    slug=${slug#bitbucket.org}
    slug=${slug#:}
    slug=${slug#/}
    slug=${slug%.git}
    ps1="$ps1\[$(tput setaf 22)\]${slug}"
    if [ "$branch" = "HEAD" ]; then
      branch="$(git rev-parse --short HEAD)"
    fi
    ps1="$ps1:${branch}${Reset} "
    # upstream
    # tracking
    # local
  else
    ps1="$ps1\[$(tput setaf 22)\](no ref)${Reset}"
  fi
  ps1="$ps1${Reset}\n"
  dir="$( printf '%s' "$PWD" | sed "s;^$HOME;~;")"
  ps1="$ps1\[$(tput setaf 238)\]$dir \[$(tput setaf 236)\]\$ ${Reset}"

  export PS1="$ps1"
}
export PROMPT_COMMAND="prompt_command"

