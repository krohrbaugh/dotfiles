#!/usr/bin/env bash
#
# Source asdf loader, when present
if [ -n ${HOMEBREW_PREFIX+x} ]; then
  asdf_loader="$HOMEBREW_PREFIX/opt/asdf/libexec/asdf.sh"

  if [ -f "$asdf_loader" ]; then
    # shellcheck source=/dev/null
    source "$asdf_loader"
  fi

  unset asdf_loader
fi

#
# Plugin settings
#

# Golang
export ASDF_GOLANG_MOD_VERSION_ENABLED=true
