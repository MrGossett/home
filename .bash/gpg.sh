gpg-agent 2>/dev/null || \
  eval "$(gpg-agent --daemon "${HOME}/.gpg-agent-info")"

if [ -f "${HOME}/.gpg-agent-info" ]; then
  source "${HOME}/.gpg-agent-info"
  export GPG_AGENT_INFO
fi

export GPG_TTY="$(tty)"
