#!/usr/bin/env bash
#
# Functions for configuring terminal applications

# shellcheck source=script/shared/paths.sh
source "$DOT_FILES/script/shared/paths.sh"
# shellcheck source=script/shared/common.sh
source "$SCRIPT_ROOT/shared/common.sh"
# shellcheck source=script/shared/macos.sh
source "$DOT_FILES/script/shared/macos.sh"

shell_preference () {
  local -r preferred_shell="$1"

  if [ "$preferred_shell" != "$SHELL" ] && [ -x "$preferred_shell" ]; then
    echo "Trying to set default shell to $preferred_shell"
    sudo dscl localhost -create /Local/Default/Users/"$USER" UserShell "$preferred_shell"
	  successn "set default shell to $preferred_shell"
  else
    warnn "skipped changing default shell to $preferred_shell: already set, or does not exist"
  fi
}

shell_zsh () {
  # Set user shell to Homebrew-installed ZSH
  shell_preference "/usr/local/bin/zsh"
}

shell_bash () {
  # Set user shell to system default (bash)
  shell_preference "/bin/bash"
}

terminal_environment () {
  # Set terminal configuration. They can only be set when _not_ running the
  # terminal app, so this first detects which app is running, and sets config
  # for the _other_ one
  if [ "$TERM_PROGRAM" = "Apple_Terminal" ]; then
    plist_preferences com.googlecode.iterm2
    successn "updated preferences for iTerm; to update Terminal preferences, run again from iTerm! O_o"
  else
    plist_preferences com.apple.Terminal
    successn "updated preferences for Terminal; to update iTerm preferences, run again from Terminal! O_o"
  fi
}

terminal_environment_rm () {
  # Remove terminal configuration.
  plist_preferences_rm com.googlecode.iterm2
  plist_preferences_rm com.apple.Terminal
}