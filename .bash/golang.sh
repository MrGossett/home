export GOROOT="$(find $HOME -maxdepth 1 -type d -name 'go1.*' | sort -Vr | head -n1)"
[ "$PATH" != *"$GOROOT/bin"* ] && export PATH="$GOROOT/bin:$PATH"

export GOPATH="$HOME/go"
[ "$PATH" != *"$GOPATH/bin"* ] && export PATH="$GOPATH/bin:$PATH"

# append GOPATH to CDPATH, with /src/bitbucket.org
# this allows `cd MrGossett` to act like `cd ~/go/src/bitbucket.org/MrGossett`
export CDPATH="${CDPATH+$CDPATH:}${GOPATH//://src/bitbucket.org:}/src/bitbucket.org"

# same for github.com
export CDPATH="$CDPATH:${GOPATH//://src/github.com:}/src/github.com"
