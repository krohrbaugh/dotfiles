#!/usr/bin/env bash
#
# Uses git's autocompletion for inner commands. Assumes an install of git's
# bash `git-completion` script at $completion below (this is where Homebrew
# tosses it, at least).
git_completion="$(brew --prefix)/share/zsh/site-functions/_git"

# shellcheck source=/dev/null
[ -f "$git_completion" ] && source "$git_completion"
