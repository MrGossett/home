export GOPATH="$HOME/go"

# append GOPATH to CDPATH, with /src/bitbucket.org
# this allows `cd MrGossett` to act like `cd ~/go/src/bitbucket.org/MrGossett`
export CDPATH="${CDPATH+$CDPATH:}${GOPATH//://src/bitbucket.org:}/src/bitbucket.org"

# same for github.com
export CDPATH="$CDPATH:${GOPATH//://src/github.com:}/src/github.com"

export PATH="$PATH:$GOPATH/bin"
