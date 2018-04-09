#!/usr/bin/env bash
#
# Source nvm scripts, when present

export NVM_DIR="$HOME/.nvm"
nvm_loader="$(brew --prefix)/opt/nvm/nvm.sh"

if [ -f "$nvm_loader" ]; then
  source "$nvm_loader"
fi

unset nvm_loader
