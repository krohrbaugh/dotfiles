#!/usr/bin/env bash
#
# Source asdf loader, when present
if type brew &>/dev/null; then
  asdf_loader="$(brew --prefix asdf)/asdf.sh"

  if [ -f "$asdf_loader" ]; then
    source "$asdf_loader"
  else
    echo "WARN: asdf not loaded"
  fi

  unset asdf_loader
fi
