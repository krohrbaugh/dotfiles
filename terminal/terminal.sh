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
    "sudo dscl . -create /Users/$USER UserShell $preferred_shell"
	  successn "set default shell to $preferred_shell"
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

terminal_preferences () {
  # Set terminal configuration. They can only be set when _not_ running the
  # terminal app, so this first detects which app is running, and sets config
  # for the _other_ one
  if [ "$TERM_PROGRAM" = "Apple_Terminal" ]; then
    plist_preferences com.googlecode.iterm2
  else
    plist_preferences com.apple.Terminal
  fi
}

terminal_preferences_rm () {
  # Remove terminal configuration.
  plist_preferences_rm com.googlecode.iterm2
  plist_preferences_rm com.apple.Terminal
}