[ -d /usr/local/bin ] && [[ "$PATH" != *"/usr/local/bin"* ]] && \
  export PATH="$PATH:/usr/local/bin"
[ -d /usr/local/sbin ] && [[ "$PATH" != *"/usr/local/sbin"* ]] && \
  export PATH="$PATH:/usr/local/sbin"
