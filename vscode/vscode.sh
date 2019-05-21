#!/usr/bin/env bash
#
# Functions for configuring VS Code

# shellcheck source=script/shared/paths.sh
source "$DOT_FILES/script/shared/paths.sh"
# shellcheck source=script/shared/common.sh
source "$DOT_FILES/script/shared/common.sh"

vscode_user_dir="$HOME/Library/Application Support/Code/User"
vscode_backup_dir="$HOME/Library/Application Support/Code/User.bak"
vscode_dotfiles_dir="$DOT_FILES/vscode/User"

vscode_environment () {
  if ! [ -L "$vscode_user_dir" ]; then
    move_directory "$vscode_user_dir" "$vscode_backup_dir"
    link_directory "$vscode_dotfiles_dir" "$vscode_user_dir"
  fi
}

vscode_environment_rm () {
  if [ -d "$vscode_backup_dir" ]; then
    remove_file "$vscode_user_dir"
    move_directory "$vscode_backup_dir" "$vscode_user_dir"
  fi
}
