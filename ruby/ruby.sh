#!/usr/bin/env bash
#
# Functions for configuring Ruby environment

# shellcheck source=script/shared/paths.sh
source "$DOT_FILES/script/shared/paths.sh"
# shellcheck source=script/shared/common.sh
source "$DOT_FILES/script/shared/common.sh"

if [ -z ${RUBIES_DIR+x} ]; then
  RUBIES_DIR="$HOME/.rubies"
fi

ruby_environment () {
  make_directory "$RUBIES_DIR"
}

ruby_environment_rm () {
  remove_directory "$RUBIES_DIR"
}

ruby_update () {
  # Install latest stable MRI Ruby
  ruby-install --latest --no-reinstall ruby
}
