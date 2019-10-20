#!/usr/bin/env bash
#
# Source asdf completion, when present
if command -v brew &>/dev/null; then
  # NOTE: It's possible that this path changes in the future, but hard-coding
  # is faster than embedding `brew --prefix asdf`. \o/
  asdf_completion="/usr/local/opt/asdf/etc/bash_completion.d/asdf.bash"

  if [ -f "$asdf_completion" ]; then
    # shellcheck source=/dev/null
    source "$asdf_completion"
  else
    echo "WARN: asdf completion not loaded"
  fi

  unset asdf_completion
fi