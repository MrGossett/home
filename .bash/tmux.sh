if [[ `uname` == 'Darwin' ]]; then
  # setup local pasteboard service
  launchctl load "$HOME/Library/LaunchAgents/pbcopy.plist" 2>/dev/null && \
    launchctl start local.pbcopy
fi
