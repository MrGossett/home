#!/usr/bin/env bash

function __is_interactive_shell {
  if [ -n "$SSH_CLIENT" ] && [ -n "$SSH_TTY" ]; then
    return 0
  elif [[ -t 0 || -p /dev/stdin ]]; then
    return 0
  else
    return 1
  fi
}

function set_term {
  # bail if this is not a TTY
  __is_interactive_shell || return 0

  # bail if TERM already supports 256 colors
  [[ "$TERM" == *"-256color" ]] && return 0

  # find a 256-color term from the terminfo database
  search="/lib/terminfo"
  if [[ "$(uname -s)" == "Darwin" ]]; then
    search="/usr/share/terminfo"
  fi
  term=$(find $search -type f -name *-256color | xargs basename | sort -r | head -n 1)

  # if we found one, then export it as TERM
  [ -n "$term" ] && export TERM="$term"
}
set_term

function prompt_command() {
  code=$? # capture exit code from last command for later use
  __is_interactive_shell || return 0

  # local vars for colors
  Red="\[$(tput setaf 1)\]"
  DarkRed="\[${Red}\]"
  Green="\[$(tput setaf 2)\]"
  Blue="\[$(tput setaf 4)\]"
  Purple="\[$(tput setaf 5)\]"
  Grey="\[$(tput setaf 8)\]"
  Reset="\[$(tput sgr0)\]"
  if [[ "$(tput colors)" == "256" ]]; then
    Blue="\[$(tput setaf 27)\]"
    DarkRed="\[$(tput setaf 52)\]"
    Purple="\[$(tput setaf 54)\]"
  fi

  # newline after last command's output to kick off prompt
  local ps1="\n"

  ### SHELLSTACK

  # Last Command indicator
  if [ $code -eq 0 ]; then
    ps1+="${Green}✔"
  else
    ps1+="${Red}✖"
  fi
  ps1+="${Reset} "

  # user@hostname
  ps1+="${DarkRed}${USER:-$(whoami)}${Grey}@${Purple}$(hostname -s)${Reset} "

  # Docker Machine name
  if [[ -n "$DOCKER_MACHINE_NAME" ]]; then
    ps1+="${Blue}dm:$DOCKER_MACHINE_NAME${Reset} "
  fi

  # AWS profile
  if [[ -n "$AWS_DEFAULT_PROFILE" ]]; then
    ps1+="${Blue}aws:${AWS_DEFAULT_PROFILE}${Reset} "
  fi

  ## git info
  # git branch
  if $(git rev-parse -q HEAD >/dev/null 2>&1); then
    branch=$(git rev-parse --abbrev-ref HEAD)
    slug=$(git remote get-url --push origin)
    slug=${slug/git@github.com:/}
    slug=${slug/.git/}
    ps1+="${Grey}${slug}"
    if [[ "$branch" == "HEAD" ]]; then
      branch="$(git rev-parse --short HEAD)"
    fi
    ps1+=":${branch}${Reset} "
    # upstream
    # tracking
    # local
  fi
  ps1+="${Reset}\n"
  ps1+="${Red}${PWD/$HOME/~}${Grey} \$ ${Reset}"

  export PS1="$ps1"
}
export PROMPT_COMMAND="prompt_command"

