function rmi-docker() {
  docker images -q --filter 'dangling=true' | xargs docker rmi
}

function drop-containers() {
  docker ps -aq | xargs docker rm -fv
}

