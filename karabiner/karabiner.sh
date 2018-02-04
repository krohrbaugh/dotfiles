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

karabiner_private_xml () {
  local xml_src="$DOT_FILES/karabiner/key_remap.xml"
  make_directory "$KARABINER_XML_DIR"
  copy_file "$xml_src" "$KARABINER_XML_PATH"
}

karabiner_private_xml_rm () {
  remove_file "$KARABINER_XML_PATH"
}

karabiner_get_mappings () {
  xmlstarlet sel -t -v '//identifier' "$KARABINER_XML_PATH"
}

karabiner_enable_mappings () {
  local action=$1
  local -r mappings=$(xmlstarlet sel -t -v '//identifier' "$KARABINER_XML_PATH")
  for mapping in $mappings
  do
    $($KARABINER_CLI enable $mapping)
    if [ $($KARABINER_CLI changed | grep "$mapping=1") ]; then
      success "Karabiner $mapping enabled"
    else
      warn "Karabiner $mapping failed to enable"
    fi
  done
  $($KARABINER_CLI relaunch)
}

karabiner_launch () {
	/usr/bin/open "$KARABINER_APP"
	$($KARABINER_CLI reloadxml)
}

karabiner_quit () {
	osascript -e "quit app \"$KARABINER_APP\""
}