autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit

for f in $HOME/.config/zsh/*; do
  source "$f"
done
