#!/usr/bin/env bash
#
# Functions for configuring Node environment

# shellcheck source=script/shared/paths.sh
source "$DOT_FILES/script/shared/paths.sh"
# shellcheck source=script/shared/common.sh
source "$DOT_FILES/script/shared/common.sh"

node_environment () {
  make_directory "$NVM_DIR"
}

node_environment_rm () {
  remove_directory "$NVM_DIR"
}
