#!/usr/bin/env bash
if [ -z ${DOTFILES_ROOT+x} ]; then
  DOTFILES_ROOT="$(git rev-parse --show-toplevel)"
fi

if [ -z ${SCRIPT_ROOT+x} ]; then
  SCRIPT_ROOT="${DOTFILES_ROOT}/script"
fi
