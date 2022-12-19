#!/bin/bash
#
# Source: https://github.com/mathiasbynens/dotfiles/blob/master/.osx
#         https://github.com/paulirish/dotfiles/blob/master/.osx
#

echo ''
if [ -n "$hostname" ]
then
  osascript -e 'tell application "System Settings" to quit'

  echo "Setting hostname to $hostname. Super-user password required:"

  sudo -k

  # Set computer name (as done via System Preferences → Sharing)
  #   See: http://muppet.wikia.com/wiki/Sweetums
  sudo scutil --set ComputerName $hostname
  sudo scutil --set HostName $hostname
  sudo scutil --set LocalHostName $hostname
  sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string $hostname

  echo "Hostname set to $hostname!"
else
  echo "No hostname specified!"
  echo "Usage: hostname=desired_hostname ./macos/set-machine-name.sh"
fi


