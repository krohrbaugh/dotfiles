#!/bin/bash
#
# Source: https://github.com/mathiasbynens/dotfiles/blob/master/.osx
#         https://github.com/paulirish/dotfiles/blob/master/.osx
#

# Request & keep-alive `sudo`
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Set computer name (as done via System Preferences → Sharing)
# 	See: http://muppet.wikia.com/wiki/Sweetums
HOSTNAME="beaker"
sudo scutil --set ComputerName $HOSTNAME
sudo scutil --set HostName $HOSTNAME
sudo scutil --set LocalHostName $HOSTNAME
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string $HOSTNAME

unset HOSTNAME
