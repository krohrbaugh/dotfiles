#!/usr/bin/env bash
#
# Functions for configuring Sublime Text 3

# shellcheck source=script/shared/paths.sh
source "$DOT_FILES/script/shared/paths.sh"
# shellcheck source=script/shared/common.sh
source "$DOT_FILES/script/shared/common.sh"

sl3_user_dir="$HOME/Library/Application Support/Sublime Text 3/Packages/User"
sl3_backup_dir="$HOME/Library/Application Support/Sublime Text 3/Packages/User.bak"
sl3_dotfiles_dir="$DOT_FILES/sublime3/User"

sublime3 () {
  if ! [ -L "$sl3_user_dir" ]; then
    move_directory "$sl3_user_dir" "$sl3_backup_dir"
    link_directory "$sl3_dotfiles_dir" "$sl3_user_dir"
  fi
}

sublime3_rm () {
  if [ -L "$sl3_user_dir" ]; then
    remove_file "$sl3_user_dir"
    move_directory "$sl3_backup_dir" "$sl3_user_dir"
  fi
}
