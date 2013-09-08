#!/bin/bash
#
# Source: https://github.com/mathiasbynens/dotfiles/blob/master/.osx
#         https://github.com/paulirish/dotfiles/blob/master/.osx
#

echo ''
if [ -n "$hostname" ]
then
  echo "Setting hostname to $hostname; super-user password required."

  # Request & keep-alive `sudo`
  sudo -v
  while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

  # Set computer name (as done via System Preferences → Sharing)
  #   See: http://muppet.wikia.com/wiki/Sweetums
  sudo scutil --set ComputerName $hostname
  sudo scutil --set HostName $hostname
  sudo scutil --set LocalHostName $hostname
  sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string $hostname

  echo "Hostname set to $hostname!"
else
  echo "No hostname specified!"
  echo "Usage: hostname=desired_hostname ./osx/set-machine-name.sh"
fi


