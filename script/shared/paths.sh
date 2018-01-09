#!/usr/bin/env bash
if [ -z ${DOT_FILES+x} ]; then
  DOT_FILES="$(git rev-parse --show-toplevel)"
fi

if [ -z ${SCRIPT_ROOT+x} ]; then
  SCRIPT_ROOT="${DOT_FILES}/script"
fi
