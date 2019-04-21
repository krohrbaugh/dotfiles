#!/usr/bin/env bash
#
# Functions for installing software

# shellcheck source=script/shared/paths.sh
source "$DOT_FILES/script/shared/paths.sh"
# shellcheck source=script/shared/common.sh
source "$DOT_FILES/script/shared/common.sh"

homebrew_bundle () {
  brew update
  info 'Checking Brewfile . . . '
  brew bundle check --global || brew bundle --global
}

homebrew_update () {
  brew update
}

homebrew_upgrade () {
  brew upgrade
}

homebrew_info () {
  brew info
}
