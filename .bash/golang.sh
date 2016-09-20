#!/usr/bin/env bash

function install-go() {
  local GO_VERSION=1.6
  mkdir -p /usr/local/src/go

  git clone --branch release-branch.go1.4 --depth 1 git@github.com:golang/go.git /usr/local/src/go/1.4
  (
    cd /usr/local/src/go/1.4/src
    ./make.bash
  )

  git clone --branch "release-branch.go$GO_VERSION" --depth 1 git@github.com:golang/go.git "/usr/local/src/go/$GO_VERSION"
  (
    cd "/usr/local/src/go/${GO_VERSION}/src"
    GOROOT_BOOTSTRAP=/usr/local/src/go/1.4 ./make.bash
  ) 
}

# find all subdirectories of /usr/local/src/go, reverse-sort, and join with :
export GOPATH=$(
  find /usr/local/src/go -type d -depth 1 | sort -r | xargs printf "%s:"
)
# set GOROOT to the first dir in GOPATH (should be the latest version of go)
export GOROOT="${GOPATH%%:*}"

# prepend ~/go to GOPATH, chomp trailing :
export GOPATH="$HOME/go:${GOPATH%:}"

# `go install` will put binaries in GOBIN, which we set to the first dir in
# GOPATH here (i.e., ~/go)
export GOBIN="${GOPATH%%:*}/bin"

# ensure all of the bin paths are in PATH
bins="${GOPATH//://bin:}/bin"
[ "$PATH" != *"$bins"* ] && export PATH="$bins:$PATH"

# append GOPATH to CDPATH, with /src/github.com
# this allows `cd MrGossett` to act like `cd ~/go/src/github.com/MrGossett`
export CDPATH="${CDPATH+$CDPATH:}${GOPATH//://src/github.com:}/src/github.com"

# make sure godoc is always running
(godoc -http=:6060 2>/dev/null &)
