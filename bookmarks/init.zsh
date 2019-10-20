#!/usr/bin/env bash
setopt autocd autopushd pushdsilent pushdtohome pushdignoredups

init_bookmarks () {
  permanent_bookmark_path="$1"
  user_bookmark_file="$2"
  local -a bookmark_files=()

  # Find permanent (checked-in) bookmarks, excluding zsh and md extensions
  if [ -d "$permanent_bookmark_path" ]; then
    while IFS='' read -r line; do
      bookmark_files+=("$line")
    done < <(find "$permanent_bookmark_path" -type f ! -name "*.zsh" ! -name "*.md")
  fi

  # Optionally include bookmarks from user home
  [ -f "$user_bookmark_file" ] && bookmark_files+=("$user_bookmark_file")

  for file in "${bookmark_files[@]}"; do
    read_bookmark_file "$file"
  done
}

read_bookmark_file () {
  bookmark_file="$1"
  grep -v '^ *#' < "$bookmark_file" | while IFS= read -r line; do
    set_bookmark "$line"
  done
}

set_bookmark () {
  bookmark_line="$1"
  bookmark_pair=("${(s/=/)bookmark_line}")
  read -r bookmark_name bookmark_path <<<"${(e)bookmark_pair}"
  if [ -d "$bookmark_path" ]; then
    hash -d "$bookmark_name"="$bookmark_path"
  fi
}

init_bookmarks "$DOT_FILES/bookmarks" "$HOME/.zsh_bookmarks"

unset -f set_bookmark read_bookmark_file init_bookmarks
