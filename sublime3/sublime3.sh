#!/usr/bin/env bash
#
# Functions for configuring Sublime Text 3

# shellcheck source=script/shared/paths.sh
source "$DOT_FILES/script/shared/paths.sh"
# shellcheck source=script/shared/common.sh
source "$DOT_FILES/script/shared/common.sh"

sublime3 () {
  _sublime3_declarations
  move_directory "$sl3_user_dir" "$sl3_backup_dir"
  link_directory "$sl3_dotfiles_dir" "$sl3_user_dir"
  _sublime3_unset
}

sublime3_rm () {
  _sublime3_declarations
  remove_file "$sl3_user_dir"
  move_directory "$sl3_backup_dir" "$sl3_user_dir"
  _sublime3_unset
}

_sublime3_declarations () {
  # Library/Application Support/Sublime Text 3/Packages/User
  sl3_user_dir=~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
  sl3_backup_dir=~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User.bak
  sl3_dotfiles_dir="$DOT_FILES/sublime3/User"
}

_sublime3_unset () {
  unset sl3_user_dir
  unset sl3_backup_dir
  unset sl3_dotfiles_dir
}
