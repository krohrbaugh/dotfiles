#!/usr/bin/env bash
#
# Provides macOS scripting functionality

plist_preferences () {
  local app_domain="$1"
  local plist="$app_domain.plist"
  local plist_src="$DOT_FILES/files/plists/$plist"
  local plist_dest="$HOME/Library/Preferences/$plist"
  local plist_cache="$HOME/Library/Caches/$app_domain"

  if [ -f "$plist_src" ]; then
    copy_file "$plist_src" "$plist_dest"
    if [ -f "$plist_cache" ]; then
      remove_file "$plist_cache"
    fi
    defaults read "$plist_dest" &>/dev/null
    successn "installed $plist"
  else
    warnn "skipped installing $plist - already exists"
  fi
}

plist_preferences_rm () {
  local app_domain="$1"
  local plist="$app_domain.plist"
  local plist_dest="$HOME/Library/Preferences/$plist"
  local plist_cache="$HOME/Library/Caches/$app_domain"

  if [ -f "$plist_dest" ]; then
    remove_file "$plist_dest"
    if [ -f "$plist_cache" ]; then
      remove_file "$plist_cache"
    fi
    defaults delete "$app_domain" &>/dev/null || true
    successn "uninstalled $plist"
  else
    warnn "skipped uninstalling $plist - does not exist"
  fi
}
