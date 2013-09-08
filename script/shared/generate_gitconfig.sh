#!/bin/bash
#
# bootstrap installs things.
source "${DOTFILES_ROOT}/script/shared/common.sh"

generate_gitconfig () {
  if ! [ -f git/gitconfig.symlink ]
  then
    info 'setup gitconfig'

    user ' - What is your github author name?'
    read -e git_authorname
    user ' - What is your github author email?'
    read -e git_authoremail

    sed -e "s/AUTHORNAME/$git_authorname/g" -e "s/AUTHOREMAIL/$git_authoremail/g" git/gitconfig.template > git/gitconfig.symlink

    success 'generated gitconfig'
  else
    info 'skipped gitconfig'
    echo ''
  fi
}
