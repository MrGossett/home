function install-go() {
  local version=${1:-1.7}
  mkdir -p /usr/local/src/go

  [ -d "/usr/local/src/go/$version" ] && \
    echo "Go $version is already installed" >&2 && \
    return 1

  [ ! -d /usr/local/src/go/1.4 ] && install-go "1.4"

  git clone --branch "release-branch.go$version" --depth 1 \
    git@github.com:golang/go.git "/usr/local/src/go/$version"
  (
    cd "/usr/local/src/go/${version}/src"
    [[ "$version" > "1.4" ]] && export GOROOT_BOOTSTRAP=/usr/local/src/go/1.4
    ./make.bash
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
# same for bitbucket.org
export CDPATH="$CDPATH:${GOPATH//://src/bitbucket.org:}/src/bitbucket.org"

# make sure godoc is always running
(godoc -http=:6060 2>/dev/null &)
