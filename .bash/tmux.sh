if [[ `uname` == 'Darwin' ]]; then
  # setup local pasteboard service
  if [[ ! -f "$HOME/Library/LaunchAgents/pbcopy.plist" ]]; then
    ln -s "$HOME/.tmux/pbcopy.plist" "$HOME/Library/LaunchAgents/pbcopy.plist"
  fi
  launchctl load "$HOME/Library/LaunchAgents/pbcopy.plist" 2>/dev/null && \
    launchctl start local.pbcopy
fi
