gpg-agent 2>/dev/null || \
  eval $(gpg-agent --daemon --write-env-file "${HOME}/.gpg-agent-info")

if [ -f "${HOME}/.gpg-agent-info" ]; then
  . "${HOME}/.gpg-agent-info"
  export GPG_AGENT_INFO
fi
