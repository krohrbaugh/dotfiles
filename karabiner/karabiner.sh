#!/usr/bin/env bash
#
# Configures Karabiner
set -e
set -o pipefail

if [ -z ${SCRIPT_ROOT+x} ]; then
  SCRIPT_ROOT="$DOT_FILES/script"
fi 
if [ -z ${KARABINER_APP+x} ]; then
  KARABINER_APP="/Applications/Karabiner.app"
fi
if [ -z ${KARABINER_CLI+x} ]; then
  KARABINER_CLI="$KARABINER_APP/Contents/Library/bin/karabiner"
fi
if [ -z ${KARABINER_NAME+x} ]; then
  KARABINER_NAME="Karabiner"
fi
if [ -z ${KARABINER_XML_DIR+x} ]; then
  KARABINER_XML_DIR="$HOME/Library/Application Support/Karabiner"
fi
if [ -z ${KARABINER_XML_PATH+x} ]; then
  KARABINER_XML_PATH="$KARABINER_XML_DIR/private.xml"
fi

# shellcheck source=script/shared/common.sh
source "${SCRIPT_ROOT}/shared/common.sh"

karabiner_login_item () {
  local props="{name:\"$KARABINER_NAME\",path:\"$KARABINER_APP\"}"
  osascript -e "tell application \"System Events\" to make login item at end with properties $props" &>/dev/null
  if [ $? -eq 0 ]; then
    success "Installed $KARABINER_NAME login item"
  else
    warn "$KARABINER_NAME login item not installed"
  fi
}

karabiner_login_item_rm () {
  osascript -e "tell application \"System Events\" to delete login item \"$KARABINER_NAME\"" &>/dev/null
  if [ $? -eq 0 ]; then
    success "Removed $KARABINER_NAME login item"
  else
  	warn "$KARABINER_NAME login item not found"
  fi
}