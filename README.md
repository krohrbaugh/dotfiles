# Dot Files 

My basic user preferences and configuration files, mostly cobbled together from
various examples and repositories that I've found across the web.

I'm a Unix nub, so proceed with caution should you wish to reuse any of it.

## Installation

```sh
mkdir -p ~/Code/personal && cd ~/Code/personal
git clone git@github.com:krohrbaugh/dotfiles.git ~/Code/personal/dotfiles
cd ~/Code/personal/dotfiles
./script/bootstrap
```

### OS X Preferences

On a fresh Mac OS X install, you may also wish to set some 
[sensible system preferences][0]:

```sh
cd ~/Code/personal/dotfiles
./osx/set-defaults.sh
```

To set your Mac's machine name:

 1. Edit the script to set the desired name
 1. Run `./osx/set-machine-name.sh`

## Environment
I am running on Mac OS X, using zsh as my shell.

## Credits

Many aspects of this setup is based on (if not straight copied) from other people's setups:

 - [Zach Holman's dotfiles][4]
 - [Mathias Bynens' dotfiles][0]
 - [Ryan Bates' dotfiles][1]

[0]: https://github.com/mathiasbynens/dotfiles
[1]: https://github.com/ryanb/dotfiles/
[4]: https://github.com/holman/dotfiles/
[2]: https://github.com/robbyrussell/oh-my-zsh
[3]: https://github.com/carlhuda/janus
