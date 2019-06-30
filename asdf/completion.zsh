#!/usr/bin/env bash
#
# Source asdf completion, when present
if type brew &>/dev/null; then
  asdf_completion="$(brew --prefix asdf)/etc/bash_completion.d/asdf.bash"

  if [ -f "$asdf_completion" ]; then
    source "$asdf_completion"
  else
    echo "WARN: asdf completion not loaded"
  fi

  unset asdf_completion
fi