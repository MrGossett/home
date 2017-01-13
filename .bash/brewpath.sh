[ -d /usr/local/bin ] && [[ "$PATH" != *"/usr/local/bin"* ]] && \
  export PATH="/usr/local/bin:$PATH"
[ -d /usr/local/sbin ] && [[ "$PATH" != *"/usr/local/sbin"* ]] && \
  export PATH="/usr/local/sbin:$PATH"
