#!/usr/bin/env bash
#
# Source asdf loader, when present
if command -v brew &>/dev/null; then
  # NOTE: It's possible that this path changes in the future, but hard-coding
  # is faster than embedding `brew --prefix asdf`. \o/
  asdf_loader="/usr/local/opt/asdf/asdf.sh"

  if [ -f "$asdf_loader" ]; then
    # shellcheck source=/dev/null
    source "$asdf_loader"
  else
    echo "WARN: asdf not loaded"
  fi

  unset asdf_loader
fi
