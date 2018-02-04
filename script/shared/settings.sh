#!/usr/bin/env bash
#
# Manages settings for various applications

# shellcheck source=script/shared/paths.sh
source "${SCRIPT_ROOT}/shared/paths.sh"
# shellcheck source=script/shared/common.sh
source "${SCRIPT_ROOT}/shared/common.sh"

# Applications and software (managed by homebrew-bundle, see homebrew/Brewfile.symlink)
install_dependencies () {
  if [ -f "$HOME/.Brewfile" ]; then
    info 'installing from Brewfile . . . '
    brew bundle check --global || brew bundle --global
  fi
}

install_plist () {
  local app_domain="$1"
  local plist="$app_domain.plist"
  local plist_src="$DOT_FILES/files/plists/$plist"
  local plist_dest="$HOME/Library/Preferences/$plist"
  local plist_cache="$HOME/Library/Caches/$app_domain"

  if [ -f "$plist_src" ]; then
    copy_file "$plist_src" "$plist_dest"
    if [ -f "$plist_cache" ]; then
      remove_file "$plist_cache"
    fi
    defaults read "$plist_dest" &>/dev/null
    success "Installed $plist"
  else
    warn "skipped installing $plist - already exists"
  fi
}

uninstall_plist () {
  local app_domain="$1"
  local plist="$app_domain.plist"
  local plist_dest="$HOME/Library/Preferences/$plist"
  local plist_cache="$HOME/Library/Caches/$app_domain"

  if [ -f "$plist_dest" ]; then
    remove_file "$plist_dest"
    if [ -f "$plist_cache" ]; then
      remove_file "$plist_cache"
    fi
    defaults delete "$app_domain" &>/dev/null || true
    success "Uninstalled $plist"
  else
    warn "skipped uninstalling $plist - does not exist"
  fi
}

# CLI
set_default_shell () {
  # Set user shell to Homebrew-installed ZSH
  local homebrew_zsh="/usr/local/bin/zsh"

  if [ "$homebrew_zsh" != "$SHELL" ]; then
    "sudo dscl . -create /Users/$USER UserShell /usr/local/bin/zsh"
	  success 'set default shell to ZSH'
  else
    infon 'default shell already ZSH'
  fi
}

set_terminal_settings () {
  # Set terminal configuration. They can only be set when _not_ running the
  # terminal app, so this first detects which app is running, and sets config
  # for the _other_ one
  if [ "$TERM_PROGRAM" = "Apple_Terminal" ]; then
    install_plist com.googlecode.iterm2
  else
    install_plist com.apple.Terminal
  fi
}

remove_terminal_settings () {
  # Remove terminal configuration.
  uninstall_plist com.googlecode.iterm2
  uninstall_plist com.apple.Terminal
}

# Fonts
get_fonts () {
  find "$DOT_FILES/files/fonts" -name '*.otf'
}

install_fonts () {
  infon 'installing fonts . . .'
  local -r fonts=$(get_fonts)

  for font in $fonts
  do
  	font_name=$(basename "${font%.*}")
  	dest="$HOME/Library/Fonts/$(basename "${font}")"
    
    if ! [ -f "$dest" ]; then
      copy_file "$font" "$dest"
    else
      infon "skipped $font_name: already installed"
    fi
  done
}

remove_fonts () {
  local -r fonts=$(get_fonts)

  for font in $fonts
  do
  	font_name=$(basename "${font%.*}")
  	dest="$HOME/Library/Fonts/$(basename "${font}")"
    
    if [ -f "$dest" ]; then
      remove_file "$dest"
    else
      infon "skipped $font_name: already installed"
    fi
  done
}


