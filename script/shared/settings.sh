#!/usr/bin/env bash
#
# Manages settings for various applications
source "${SCRIPT_ROOT}/shared/paths.sh"
source "${SCRIPT_ROOT}/shared/common.sh"

# Applications and software (managed by homebrew-bundle, see homebrew/Brewfile.symlink)
install_dependencies () {
  if [ -f "$HOME/.Brewfile" ]; then
    info 'installing from Brewfile . . . '
    brew bundle check --global || brew bundle --global
  fi
}

# Fonts
get_fonts () {
  find $DOTFILES_ROOT/fonts -name \*.otf
}

install_fonts () {
  info 'installing fonts . . .\n'
  local fonts=$(get_fonts)

  for font in $fonts
  do
  	font_name=$(basename "${font%.*}")
  	dest="$HOME/Library/Fonts/$(basename "${font}")"
    
    if ! [ -f $dest ]; then
      copy_file $font $dest
    else
      info "skipped $font_name: already installed\n"
    fi
  done
}

remove_fonts () {
  local fonts=$(get_fonts)

  for font in $fonts
  do
  	font_name=$(basename "${font%.*}")
  	dest="$HOME/Library/Fonts/$(basename "${font}")"
    
    if [ -f $dest ]; then
      remove_file $dest
    else
      info "skipped $font_name: already installed\n"
    fi
  done
}
