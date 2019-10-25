# Dot Files

My basic user preferences and configuration files, mostly cobbled together from
various examples and repositories that I've found across the web.

## Environment

I am running on macOS High Sierra, using zsh as my shell.

## Installation

### Fresh macOS install

For a completely fresh installation, start by generating a `strap.sh` script. It
will checkout the dotfiles, and invoke the appropriate scripts to set things up
and install various software.

To do that, visit [strap.githubapp.com][strap].

### Existing install / updating

The project is organized using the [scripts-to-rule-them-all][scripts] structure.

* `script/bootstrap`: setup dependencies (Uses [Strap][strap] as outlined above.)
* `script/setup`: setup initial state (e.g., directories, etc.)
* `script/update`: update to current state/commit
* `script/nuke`: uninstall dotfiles

### Specific software and settings

The global scripts delegate out to various topic-level scripts, such that it's
also possible to only setup/update/nuke the relevant context you're interested in.

For instance, to just update software, run `homebrew/update` or to just nuke
terminal settings, run `terminal/nuke`.

### macOS Preferences

On a fresh macOS install, you may also wish to set some
[sensible system preferences][mathiasbynens]:

``` sh
~dotfiles
./macos/set-defaults.sh
```

To set your Mac's machine name:

``` sh
~dotfiles
hostname=my_hostname ./macos/set-machine-name.sh
```

### Shell customization

Some repositories can be too large for the `git` info displayed in the zsh prompt.

To disable it for a specific repo, run the following inside it:

```bash
git config --bool shell.showdirty false
```

(It's also possible to disable the upstream status by setting the
`shell.showpush` flag.)

### Sublime Text 3

See the README file in the `sublime3` directory for details.

### VSCode

See the README file in the `vscode` directory for details.

## Credits

Many aspects of this setup is based on (if not straight copied) from other
people's setups:

 - [Zach Holman's dotfiles][holman]
 - [Mathias Bynens' dotfiles][mathiasbynens]
 - [Ryan Bates' dotfiles][ryanb]

[holman]: https://github.com/holman/dotfiles/
[mathiasbynens]: https://github.com/mathiasbynens/dotfiles
[ryanb]: https://github.com/ryanb/dotfiles/
[scripts]: https://github.com/github/scripts-to-rule-them-all
[strap]: https://strap.githubapp.com/
