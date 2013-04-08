#
# Ruby aliases
#
alias bx="bundle exec $1"
alias be="bundle exec $1"

# Purge gems
alias gem-purge="gem list | cut -d' ' -f1 | xargs gem uninstall -aIx"

#
# Rails aliases
#
alias r="rails"