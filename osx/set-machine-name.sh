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
sudo scutil --set ComputerName "Sweetums"
sudo scutil --set HostName "Sweetums"
sudo scutil --set LocalHostName "Sweetums"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "Sweetums"