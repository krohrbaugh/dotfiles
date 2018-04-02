#!/usr/bin/env bash
#
# File operation functions

# shellcheck source=script/shared/io.sh
source "$SCRIPT_ROOT/shared/io.sh"

# File operations
link_file () {
  local -r existing_file="$1"
  local -r new_link="$2"
  if [ -f "$existing_file" ]; then
    ln -s "$existing_file" "$new_link"
    successn "linked $new_link to $existing_file"
  else
    warnn "skipped linking $(basename "$existing_file") - file does not exist"
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

# Directory operations
link_directory () {
  local -r existing_dir="$1"
  local -r new_link="$2"
  if [ -d "$existing_dir" ]; then
    ln -s "$existing_dir" "$new_link"
    successn "linked $new_link to $existing_dir"
  else
    warnn "skipped linking $(basename "$existing_dir") - directory does not exist"
  fi
}

make_directory () {
  local -r directory="$1"

  if ! [ -d "$directory" ]; then
    mkdir -p "$directory"
    successn "Created directory: $directory"
  fi
}

move_directory () {
  if [ -d "$1" ]; then
    mv "$1" "$2"
    successn "moved $1 to $2"
  else
    warnn "skipped moving $(basename "$1") - directory does not exist"
  fi
}

remove_directory () {
  if [ -d "$1" ]; then
    rm -rf "$1"
    successn "removed $1"
  else
    warnn "skipped deleting $(basename "$1") - directory does not exist"
  fi
}
