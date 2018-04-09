#!/usr/bin/env bash
#
# Source chruby scripts, when present

chruby_dir="$(brew --prefix)/share/chruby"
chruby_loader="$chruby_dir/chruby.sh"
chruby_auto="$chruby_dir/auto.sh"

if [ -f "$chruby_loader" ]; then
  source "$chruby_loader"
  if [ -f "$chruby_auto" ]; then
    source "$chruby_auto"
  fi
fi

unset chruby_dir
unset chruby_loader
unset chruby_auto
