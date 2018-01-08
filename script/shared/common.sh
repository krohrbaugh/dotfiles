#!/usr/bin/env bash
#
# common functions

info () {
  printf "  [ \033[00;34m..\033[0m ] $1"
}

user () {
  printf "\r  [ \033[0;33m??\033[0m ] $1 "
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

warn () {
  echo ''
  printf "\r\033[2K  [ \033[00;35m!!\033[0m ] $1\n"
  echo ''
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}

confirm () {
  local __confirmed="$2"
  local action=false
  local response=''

  warn "$1"
  user 'Are you sure? [Y]es, [N]o '
  read -n 1 response

  case "$response" in
    y | Y )
      action=true;;
  esac

  eval $__confirmed="'$action'"
}

link_file () {
  ln -s $1 $2
  success "linked $2 to $1"
}

remove_file () {
  rm -rf $1
  success "removed $1"
}

move_file () {
  mv $1 $2
  success "moved $1 to $2"
}

copy_file () {
  cp $1 $2
  success "copied $(basename $1) to $2"
}

make_directory () {
  mkdir -p "$1"
  success "Created directory: $1"
}