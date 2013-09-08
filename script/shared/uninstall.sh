#!/bin/bash
#
# delete symlinked files

DOTFILES_ROOT="`pwd`"
source "${DOTFILES_ROOT}/script/shared/common.sh"

delete_all() {
  for source in `find $DOTFILES_ROOT -maxdepth 2 -name \*.symlink`
  do
    dest="$HOME/.`basename \"${source%.*}\"`"
    if [ -f $dest ] || [ -d $dest ]
    then
      remove_file $dest
    fi
  done
}
