# Directory bookmarks

Adds named directories to ZSH command hash, if the directory exists.

## Use

Define bookmarks in a bookmark file (one bookmark per line):

```bash
# ./bookmarks/global
name=path/to/bookmark
name2=path/to/other/bookmark
```

To use the bookmark from the shell:

```bash
~name # => cd path/to/bookmark
```

To add bookmarks but not commit them to `dotfiles`, add them to
`~/.zsh_bookmarks` using the same format outlined above (`name=path` pairs.)

_NOTE:_ If a bookmark's path does not exist, it will be ignored.
