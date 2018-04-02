#!/bin/bash
#
# Install software

# shellcheck source=script/shared/common.sh
source "$SCRIPT_ROOT/shared/common.sh"

homebrew_bundle () {
  info 'checking Brewfile . . . '
  brew bundle check --global || brew bundle --global
}
