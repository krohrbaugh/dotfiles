# Homebrew configuration

## Exclusion lists

It's expected that some machines (e.g., work ones) may not need or want all of
the software listed in `Brewfile.symlink`. To accommodate this, create one of
the following files in your home directory, depending on the type of installation:

+ `~/.homebrew_bundle_brew_exclude` - Exclude software installed via `brew`
+ `~/.homebrew_bundle_cask_exclude` - Exclude software installed via `brew cask`
+ `~/.homebrew_bundle_mas_exclude` - Exclude software installed from the Mac App Store via `mas`
+ `~/.homebrew_bundle_tap_exclude` - Exclude a tap

The contents of these files should be a list of the formulas to exclude, with one
formula per line.
