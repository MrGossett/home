export GOPATH="$HOME/go"

export PATH="$GOPATH/bin:$PATH"

function godoc() {
  # TODO: accept port as $1, default to 6060
  if [ ! -f go.mod ]
  then
    echo "error: go.mod not found" >&2
    return
  fi

  module=$(sed -n 's/^module \(.*\)/\1/p' go.mod)
  docker run \
    --rm \
    -e "GOPATH=/tmp/go" \
    -p 127.0.0.1:6060:6060 \
    -v $PWD:/tmp/go/src/$module \
    golang \
    bash -c "go get golang.org/x/tools/cmd/godoc && echo http://localhost:6060/pkg/$module && /tmp/go/bin/godoc -http=:6060"
}

function go-uncovered-exported() {
  out=$(mktemp)
  go test -coverprofile=$out .
  go tool cover -func=$out | grep -v -e 'total:' -e '100.0%' | sort -hrk 3 -k 1 |  awk '$2 ~ /^[A-Z]/'
}

function go-covered-exported() {
  out=$(mktemp)
  go test -coverprofile=$out .
  go tool cover -func=$out | grep -v -e 'total:' | grep -e '100.0%' | sort -hrk 3 -k 1 |  awk '$2 ~ /^[A-Z]/'
}

source <(golangci-lint completion bash)

complete -C "$HOME/go/bin/gocomplete" go
