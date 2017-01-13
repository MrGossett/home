export CDPATH="."

while read f; do
  source $f
done < <(find "$HOME/.bash" -type f -name '*.sh')

alias g="git "
__git_complete g __git_main

export EDITOR='vim'
alias v="vim"
alias l='ls -FGAlh'

