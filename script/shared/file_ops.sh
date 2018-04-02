#!/usr/bin/env bash
#
# File operation functions

# shellcheck source=script/shared/io.sh
source "$SCRIPT_ROOT/shared/io.sh"

link_file () {
  if [ -f "$1" ]; then
    ln -s "$1" "$2"
    successn "linked $2 to $1"
  else
    warnn "skipped linking $(basename "$1") - file does not exist"
  fi
  
}

remove_file () {
  if [ -f "$1" ]; then
    rm -rf "$1"
    successn "removed $1"
  else
    warnn "skipped deleting $(basename "$1") - file does not exist"
  fi
}

move_file () {
  if [ -f "$1" ]; then
    mv "$1" "$2"
    successn "moved $1 to $2"
  else
    warnn "skipped moving $(basename "$1") - file does not exist"
  fi
  
}

copy_file () {
  if [ -f "$1" ]; then
    cp "$1" "$2"
    successn "copied $(basename "$1") to $2"
  else
    warnn "skipped copying $(basename "$1") - file does not exist"
  fi
}

make_directory () {
  local -r directory="$1"

  if ! [ -d "$directory" ]; then
    mkdir -p "$directory"
    successn "Created directory: $directory"
  fi
}
