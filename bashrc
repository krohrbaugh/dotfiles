# This file should be loaded from ~/.bashrc
#  See home/bashrc for ~/.bashrc content
source ~/bin/dotfiles/bash/env
source ~/bin/dotfiles/bash/config
source ~/bin/dotfiles/bash/aliases
source ~/bin/dotfiles/bash/functions

# Detect proxy settings
source ~/bin/dotfiles/misc/proxy-detect

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
