#!/usr/bin/env bash
#
# Functions for configuring Node environment

# shellcheck source=script/shared/paths.sh
source "$DOT_FILES/script/shared/paths.sh"
# shellcheck source=script/shared/common.sh
source "$DOT_FILES/script/shared/common.sh"

if [ -z ${NVM_DIR+x} ]; then
  NVM_DIR="$HOME/.nvm"
fi

node_environment () {
  make_directory "$NVM_DIR"
}

node_environment_rm () {
  remove_directory "$NVM_DIR"
}

node_update () {
  # shellcheck source=node/nvm.zsh
  source "$DOT_FILES/node/nvm.zsh"
  nvm install node
}
