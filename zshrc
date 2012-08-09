# [KR] Path to dotfiles
export DOT_FILES="$HOME/bin/dotfiles"

# Path to your oh-my-zsh configuration.
export ZSH=$DOT_FILES/oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
export ZSH_THEME="krohrbaugh"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# export DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(brew cap gem git heroku osx pow rails3 ruby rvm)

source $ZSH/oh-my-zsh.sh

# krohrbaugh environment customizations
source $DOT_FILES/zsh/env
source $DOT_FILES/zsh/config
source $DOT_FILES/zsh/aliases
source $DOT_FILES/zsh/functions

# Detect proxy settings
source $DOT_FILES/misc/proxy-detect

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
