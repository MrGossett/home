#!/usr/bin/env bash

function rmi-docker() {
  docker images -q --filter 'dangling=true' | xargs docker rmi
}

function drop-containers() {
  docker ps -aq | xargs docker rm -fv
}

function use-machine() {
  local machines="$(docker-machine ls -q)"
  if [[ "$machines" != *"$1"* ]]; then
    echo "Available machines:"
    echo "$machines" | sed 's/^/  /'
    return 1
  fi

  eval $(docker-machine env $1)
}

alias dc="docker-compose"
alias dm="docker-machine"
alias dk="docker"
