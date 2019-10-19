# VSCode settings

## User settings

Run `vscode/setup` to install user settings.

_Note:_ This is invoked from `script/setup` and runs fine before or after VSCode is
installed by Homebrew.

## Extensions

_After_ installing VSCode using `homebrew`, run `vscode/update` to install
extensions. The extensions that will be installed are listed in `vscode/extensions`.

To update the list of extensions in that file (after installing a new extension from
within VSCode itself) run `vscode/dump-extensions` and then commit the modified
`vscode/extensions` file.
