#!/usr/bin/env bash
#
# common functions

info () {
  printf "  [ \\033[00;34m..\\033[0m ] %s" "$1"
}

infon () {
  info "$1"
  echo ''
}

user () {
  printf "\\r  [ \\033[0;33m??\\033[0m ] %s " "$1"
}

success () {
  printf "\\r\\033[2K  [ \\033[00;32mOK\\033[0m ] %s" "$1"
  echo ''
}

warn () {
  printf "\\r\\033[2K  [ \\033[00;35m!!\\033[0m ] %s" "$1"
  echo ''
}

fail () {
  printf "\\r\\033[2K  [\\033[0;31mFAIL\\033[0m] %s" "$1"
  echo ''
  exit
}

confirm () {
  local __confirmed
  local action
  local response

  __confirmed="$2"
  action=false
  response=''

  warn "$1"
  user 'Are you sure? [Y]es, [N]o '
  read -rn 1 response

  case "$response" in
    y | Y )
      action=true;;
  esac

  eval "$__confirmed=\"$action\""
}

link_file () {
  if [ -f "$1" ]; then
    ln -s "$1" "$2"
    success "linked $2 to $1"
  else
    warn "skipped linking $(basename "$1") - file does not exist"
  fi
  
}

remove_file () {
  if [ -f "$1" ]; then
    rm -rf "$1"
    success "removed $1"
  else
    warn "skipped deleting $(basename "$1") - file does not exist"
  fi
}

move_file () {
  if [ -f "$1" ]; then
    mv "$1" "$2"
    success "moved $1 to $2"
  else
    warn "skipped moving $(basename "$1") - file does not exist"
  fi
  
}

copy_file () {
  if [ -f "$1" ]; then
    cp "$1" "$2"
    success "copied $(basename "$1") to $2"
  else
    warn "skipped copying $(basename "$1") - file does not exist"
  fi
}

make_directory () {
  mkdir -p "$1"
  success "Created directory: $1"
}