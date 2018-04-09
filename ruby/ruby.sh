#!/usr/bin/env bash
#
# Functions for configuring Ruby environment

# shellcheck source=script/shared/paths.sh
source "$DOT_FILES/script/shared/paths.sh"
# shellcheck source=script/shared/common.sh
source "$DOT_FILES/script/shared/common.sh"

ruby_environment () {
  # Install latest stable MRI Ruby
  ruby-install ruby --no-reinstall
}

ruby_environment_rm () {
  remove_directory "$HOME/.rubies"
}
