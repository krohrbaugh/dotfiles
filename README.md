# Dot Files 
My basic user preferences and configuration files, mostly cobbled together from
various examples and repositories that I've found across the web.

This configuration is tuned for [my Boxen setup][my-boxen]. Steal from both for maximum awesome.

## Installation
The dotfiles can be installed via Boxen (preferred) or manually using shell scripts:

### Boxen-based install (personal manifest)
Inside your personal manifest file (e.g., `/opt/boxen/repo/modules/people/manifest/<github_login>.pp`):

```puppet
$dotfiles = "${boxen::config::srcdir}/dotfiles"

repository { $dotfiles:
  source => "${::github_login}/dotfiles",
  require => File[${boxen::config::srcdir}],
}

exec { "install dotfiles":
  provider => shell,
  command  => "./script/install",
  cwd      => $dotfiles,
  creates  => "${home}/.zshrc",
  require  => Repository[$dotfiles],
}
```

_NOTE:_ Boxen-based installs will _not_ generate a `~/.gitconfig` file, since it requires user input (name & email address). See the manual install section for directions for generating and linking just this file.

### Manual install (shell script)
If Boxen isn't an option, there are several scripts for installing and removing the dotfiles in the `script` directory.

To install manually:

```sh
mkdir -p ~/Code/my
git clone https://github.com/krohrbaugh/dotfiles.git ~/Code/my/dotfiles
cd ~/Code/my/dotfiles
./script/bootstrap
```

To generate just the `~/.gitconfig` file (assuming directories are created and the repository was cloned):

```sh
cd ~/Code/my/dotfiles
./script/gitconfig
```

### OS X Preferences
On a fresh Mac OS X install, you may also wish to set some 
[sensible system preferences][0]:

_NOTE:_ Consider Boxen for this task, as it simplifies system setup.

```sh
cd ~/Code/my/dotfiles
./osx/set-defaults.sh
```

To set your Mac's machine name:

```sh
cd ~/Code/my/dotfiles
hostname=my_hostname ./osx/set-machine-name.sh
```

### Sublime Text 2
To configure Sublime Text 2's user directory:

1. [Install Sublime Text (dev channel)][2]
1. [Install Package Control][3]
1. Run `sublime2/install.sh`

_NOTE:_ Consider Boxen for this task, as it can install Sublime Text, package control and perform this install all at once.

## Environment
I am running on Mac OS X, using zsh as my shell.

## Credits
Many aspects of this setup is based on (if not straight copied) from other people's setups:

 - [Zach Holman's dotfiles][4]
 - [Mathias Bynens' dotfiles][0]
 - [Ryan Bates' dotfiles][1]

[0]: https://github.com/mathiasbynens/dotfiles
[1]: https://github.com/ryanb/dotfiles/
[2]: http://www.sublimetext.com/dev
[3]: http://wbond.net/sublime_packages/package_control/installation
[4]: https://github.com/holman/dotfiles/
[my-boxen]: https://github.com/krohrbaugh/my-boxen
