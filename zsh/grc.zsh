#!/usr/bin/env bash
# Stolen from: https://github.com/holman/dotfiles
#
# GRC colorizes nifty unix tools all over the place
if command -v grc &>/dev/null && ! command -v brew &>/dev/null
then
  # shellcheck source=/dev/null
  source "$(brew --prefix)/etc/grc.bashrc"
fi