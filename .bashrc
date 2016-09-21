export CDPATH="."

for file in ~/.bash/*.sh; do source $file; done

. $HOME/.bash/gitcomplete.sh
alias g="git "
__git_complete g __git_main

export EDITOR='vim'
alias v="vim"
alias l='ls -FGAlh'

