#!/usr/bin/env bash
#
# Functions for installing software

# shellcheck source=script/shared/paths.sh
source "$DOT_FILES/script/shared/paths.sh"
# shellcheck source=script/shared/common.sh
source "$DOT_FILES/script/shared/common.sh"

# Exclude functionality (see README)
homebrew_exclude () {
  if [ -f "$1" ]; then
    paste -sd ' ' "$1"
  else
    echo "$1 does not exist"
  fi
}

HOMEBREW_BUNDLE_BREW_SKIP=$(homebrew_exclude "$HOME/.homebrew_bundle_brew_exclude")
HOMEBREW_BUNDLE_CASK_SKIP=$(homebrew_exclude "$HOME/.homebrew_bundle_cask_exclude")
HOMEBREW_BUNDLE_MAS_SKIP=$(homebrew_exclude "$HOME/.homebrew_bundle_mas_exclude")
HOMEBREW_BUNDLE_TAP_SKIP=$(homebrew_exclude "$HOME/.homebrew_bundle_tap_exclude")
export HOMEBREW_BUNDLE_BREW_SKIP
export HOMEBREW_BUNDLE_CASK_SKIP
export HOMEBREW_BUNDLE_MAS_SKIP
export HOMEBREW_BUNDLE_TAP_SKIP

homebrew_bundle () {
  brew update
  infon 'Checking Brewfile'
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
