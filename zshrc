# Path to your oh-my-zsh configuration.
export ZSH=$HOME/bin/dotfiles/oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
export ZSH_THEME="robbyrussell"

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
plugins=(git rails3 brew bundler gem osx pow ruby rvm)

source $ZSH/oh-my-zsh.sh

# krohrbaugh environment customizations
source $HOME/bin/dotfiles/zsh/env
source $HOME/bin/dotfiles/zsh/config
source $HOME/bin/dotfiles/zsh/aliases
source $HOME/bin/dotfiles/zsh/functions

# Detect proxy settings
source $DOT_FILES/misc/proxy-detect
