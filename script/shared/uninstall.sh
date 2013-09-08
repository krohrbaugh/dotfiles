#!/bin/bash
#
# delete symlinked files

DOTFILES_ROOT="`pwd`"
source "${DOTFILES_ROOT}/script/shared/io_helpers.sh"

delete_all() {
  for source in `find $DOTFILES_ROOT -maxdepth 2 -name \*.symlink`
  do
    dest="$HOME/.`basename \"${source%.*}\"`"
    if [ -f $dest ] || [ -d $dest ]
    then
      rm -rf $dest
      success "removed $dest"
    fi
  done
}
