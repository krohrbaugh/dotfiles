#!/bin/bash
#
# Links/unlinks .symlink files as dot-files in $HOME

# shellcheck source=script/shared/paths.sh
source "${SCRIPT_ROOT}/shared/paths.sh"
# shellcheck source=script/shared/common.sh
source "${SCRIPT_ROOT}/shared/common.sh"

get_dotfiles () {
  find "$DOT_FILES" -maxdepth 2 -name \*.symlink
}

install_dotfiles () {
  info 'installing dotfiles'

  dotfiles=$(get_dotfiles)

  overwrite_all=false
  backup_all=false
  skip_all=false
  nuke_all=false

  for source in $dotfiles
  do
    dest="$HOME/.$(basename \""${source%.*}"\")"

    if [ -f "$dest" ] || [ -d "$dest" ]
    then

      overwrite=false
      backup=false
      skip=false

      if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ] && [ "$nuke_all" == "false" ]
      then
        user "File already exists: ~/$(basename "$dest"), what do you want to do? [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all, [n]uke, [N]uke all?"
        read -nr 1 action

        case "$action" in
          o )
            overwrite=true;;
          O )
            overwrite_all=true;;
          b )
            backup=true;;
          B )
            backup_all=true;;
          s )
            skip=true;;
          S )
            skip_all=true;;
          n )
            overwrite=true
            skip=true;;
          N )
            overwrite_all=true
            skip_all=true;;
          * )
            ;;
        esac
      fi

      if [ "$overwrite" == "true" ] || [ "$overwrite_all" == "true" ]
      then
        remove_file "$dest"
      fi

      if [ "$backup" == "true" ] || [ "$backup_all" == "true" ]
      then
        move_file "$dest" "$dest\\.backup"
      fi

      if [ "$skip" == "false" ] && [ "$skip_all" == "false" ]
      then
        link_file "$source" "$dest"
      else
        success "skipped $source"
      fi

    else
      link_file "$source" "$dest"
    fi

  done
}

uninstall_dotfiles () {
  dotfiles=$(get_dotfiles)

  for source in $dotfiles
  do
    dest="$HOME/.$(basename \""${source%.*}"\")"
    if [ -f "$dest" ] || [ -d "$dest" ]
    then
      remove_file "$dest"
    fi
  done
}
