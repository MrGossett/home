[ -d /usr/local/bin ] && [[ "$PATH" != *"/usr/local/bin"* ]] && \
  export PATH="$PATH:/usr/local/bin"
[ -d /usr/local/sbin ] && [[ "$PATH" != *"/usr/local/sbin"* ]] && \
  export PATH="$PATH:/usr/local/sbin"
[ -f /usr/local/etc/bash_completion ] && \
  . /usr/local/etc/bash_completion

export PATH="/usr/local/opt/curl/bin:$PATH"
