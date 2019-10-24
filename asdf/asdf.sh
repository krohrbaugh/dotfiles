#!/usr/bin/env bash
#
# Functions for configuring asdf

# shellcheck source=script/shared/paths.sh
source "$DOT_FILES/script/shared/paths.sh"
# shellcheck source=script/shared/common.sh
source "$DOT_FILES/script/shared/common.sh"

asdf_plugins () {
  echo "golang elixir erlang java nodejs ruby rust scala swift"
}

asdf_setup () {
  # Install plugins
  local plugins
  plugins="$(asdf_plugins)"
  for plugin in "${plugins[@]}"
  do
    asdf plugin-add "$plugin" 2>/dev/null
  done
}

asdf_update () {
  # Update all plugins
  asdf plugin-update --all
}

asdf_nuke () {
  # Remove plugins
  local plugins
  plugins=$(asdf_plugins)
  for plugin in "${plugins[@]}"
  do
    asdf plugin-remove "$plugin" 2>/dev/null
  done
}