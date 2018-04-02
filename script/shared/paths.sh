#!/usr/bin/env bash
if [ -z ${DOT_FILES+x} ]; then
  DOT_FILES="$(git rev-parse --show-toplevel)"
fi

if [ -z ${SCRIPT_ROOT+x} ]; then
  SCRIPT_ROOT="${DOT_FILES}/script"
fi

if [ -z ${FILES_ROOT+x} ]; then
  FILES_ROOT="${DOT_FILES}/files"
fi

if [ -z ${CODE_ROOT+x} ]; then
  CODE_ROOT="$HOME/Code"
fi
