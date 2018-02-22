export CDPATH="."
export PAGER="less"

eval "$(find "$HOME/.bash" -type f -name '*.sh' | sed 's/^/source /')"

alias g="git "
__git_complete g __git_main

export EDITOR='vim'
alias v="vim"
alias l='ls -FGAlh'

export PATH="$HOME/bin:$PATH"
complete -C $HOME/go/bin/gocomplete go
