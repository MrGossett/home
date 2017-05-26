export CDPATH="."

eval "$(find "$HOME/.bash" -type f -name '*.sh' | sed 's/^/source /')"

alias g="git "
__git_complete g __git_main

export EDITOR='vim'
alias v="vim"
alias l='ls -FGAlh'

