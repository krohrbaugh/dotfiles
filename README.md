# Dot Files 

My basic user preferences and configuration files, mostly cobbled together from
various examples and repositories that I've found across the web.

I consider myself a Unix nub, so proceed with caution should you wish to reuse
any of it.

## Installation

```sh
git clone git@github.com:krohrbaugh/dotfiles.git ~/bin/dotfiles
cd ~/bin/dotfiles/
rake
```

_Note:_ The bash prompt uses [vcprompt](http://vc.gerg.ca/hg/vcprompt) to
display version control information for CVS, Git and Mercurial. This should be
built and installed somewhere on the `$PATH` (typically `~/bin`).

### OS X Preferences

On a fresh Mac OS X install, you may also wish to set some 
[sensible system preferences][0]:

```sh
rake set_osx_defaults
```

## Environment
I am running on Mac OS X, using zsh as my shell.

## Credits

Many of the setup files are based on, if not exact duplicates of, [Ryan Bates' dotfiles][1]. Files that are exact duplicates of Ryan's work contain his copyright notice.

OS X preferences are from [Mathias Bynens' dotfiles][0].

My ZSH configuration relies primarily on [Oh My Zsh][2].

My `vim` configuration relies primarily on [Janus][3].

[0]: https://github.com/mathiasbynens/dotfiles
[1]: https://github.com/ryanb/dotfiles/
[2]: https://github.com/robbyrussell/oh-my-zsh
[3]: https://github.com/carlhuda/janus
