#!/usr/bin/env bash
#
# Keep sudo priveleges while running

# shellcheck source=script/shared/common.sh
source "${SCRIPT_ROOT}/shared/common.sh"

# Continuously refresh sudo timestamp
if [ "$1" = "--sudo" ]; then
  while true; do
    mkdir -p "/var/db/sudo/$SUDO_USER"
    touch "/var/db/sudo/$SUDO_USER"
    sleep 1
  done
  exit 0
fi

cleanup() {
  set +e
  if [ -n "$SUDO_PID" ]; then
    sudo kill "$SUDO_PID"
  fi
  sudo -k
}

initialize_sudo () {
  local -r SUDO_SCRIPT="$SCRIPT_ROOT/$(basename "$0")"

  info "Enter your password (sudo access): "
  sudo -k
  sudo /usr/bin/true
  [ -f "$SUDO_SCRIPT" ]
  sudo bash "$SUDO_SCRIPT" --sudo-wait &
  SUDO_PID="$!"
  ps -p "$SUDO_PID" &>/dev/null
}

trap "cleanup" EXIT