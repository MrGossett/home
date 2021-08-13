autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
zstyle ':vcs_info:git:*' formats '%b'

NL=$'\n'
export PROMPT="$NL%(?.%F{2}✔.%F{1}✖) %F{22}\$vcs_info_msg_0_ $NL%F{238}%5~ %F{236}\$%f "
