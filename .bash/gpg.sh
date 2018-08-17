export GPG_TTY="$(tty)"

# use gpg-agent for SSH
unset SSH_AGENT_PID
export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"

