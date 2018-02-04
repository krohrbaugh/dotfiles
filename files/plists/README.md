# Property Lists Preferences

Many applications use property lists preferences stored in `~/Library/Preferences`. This directory includes XML-format property lists used to initialize such plists on new systems.

## Making Changes

It's easiest to change the settings in the source applications themselves, then copy the property list file into dotfiles. Once copied, it may be necessary to convert the file to XML so that it's human-readable (see below)

In order to test that things are working properly, it's necessary to:

1. Delete the plist: `rm ~/Library/Preferences/<app-domain>.plist`
1. Delete the plist cache (if present): `rm -rf ~/Library/Caches/<app-domain>`
1. Delete in-memory settings (if present): `defaults delete <app-domain>`
1. Re-run `./script/update`


### Converting between binary and XML plists

To generate the XML file from a binary property list file:

``` sh
plutil -convert xml1 -o <app-domain>.plist.xml -- ~/Library/Preferences/<app-domain>.plist
```

To generate a binary property list file from XML:

``` sh
plutil -convert binary1 -o <app-domain>.plist -- <app-domain>.plist.xml
```
