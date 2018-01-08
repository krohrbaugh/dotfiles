#!/usr/bin/env bash
#
# Manages settings for various applications
source "${SCRIPT_ROOT}/shared/paths.sh"
source "${SCRIPT_ROOT}/shared/common.sh"

install_dependencies () {
  if [ -f "$HOME/.Brewfile" ]; then
    info 'installing from Brewfile'
    brew bundle check --global || brew bundle --global
  fi
}

