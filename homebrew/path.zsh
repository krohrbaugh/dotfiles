# arm64 machines use /opt/homebrew, others /usr/local
if [ -d "/opt/homebrew" ]; then
  export HOMEBREW_PREFIX="/opt/homebrew"
else
  export HOMEBREW_PREFIX="/usr/local"
fi

export PATH="$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$PATH"

export MANPATH="$HOMEBREW_PREFIX/manpages:$MANPATH"
