#!/usr/bin/env bash
#
# Input/output functions

info () {
  printf "  [ \\033[00;34m..\\033[0m ] %s" "$1"
}

infon () {
  info "$1"
  echo ''
}

success () {
  printf "\\r\\033[2K  [ \\033[00;32mOK\\033[0m ] %s" "$1"
}

successn () {
  success "$1"
  echo ''
}

warn () {
  printf "\\r\\033[2K  [ \\033[00;35m!!\\033[0m ] %s" "$1"
}

warnn () {
  warn "$1"
  echo ''
}

fail () {
  printf "\\r\\033[2K  [\\033[0;31mFAIL\\033[0m] %s" "$1"
  echo ''
  exit
}

user () {
  printf "\\r  [ \\033[0;33m??\\033[0m ] %s " "$1"
}

usern () {
  user "$1"
  echo ''
}

confirm () {
  local __confirmed="$2"
  local action=false
  local response=''

  warnn "$1"
  user 'Are you sure? [Y]es, [N]o '
  read -rn 1 response

  case "$response" in
    y | Y )
      action=true;;
  esac

  eval "$__confirmed=\"$action\""
}
