#!/bin/bash
#
# Pre-req's and dependencies that everything relies on

# shellcheck source=script/shared/common.sh
source "$SCRIPT_ROOT/shared/common.sh"

#
# ~/Code directory
#
code_dir () {
  make_directory "$CODE_ROOT"
  make_directory "$CODE_ROOT/personal"
  link_file "$DOT_FILES" "$CODE_ROOT/personal/dotfiles"
}

code_dir_rm () {
  remove_file "$CODE_ROOT"
}

#
# Dotfiles setup
#
dotfiles_ls () {
  find "$DOT_FILES" -maxdepth 2 -name \*.symlink
}

dotfiles () {
  info 'installing dotfiles'

  local -r dotfiles=$(dotfiles_ls)

  local overwrite_all=false
  local backup_all=false
  local skip_all=false
  local nuke_all=false

  for source in $dotfiles
  do
    dest="$HOME/.$(basename \""${source%.*}"\")"

    if [ -f "$dest" ] || [ -d "$dest" ]; then
      overwrite=false
      backup=false
      skip=false

      if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ] && [ "$nuke_all" == "false" ]; then
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

      if [ "$overwrite" = "true" ] || [ "$overwrite_all" = "true" ]; then
        remove_file "$dest"
      fi

      if [ "$backup" = "true" ] || [ "$backup_all" = "true" ]; then
        move_file "$dest" "$dest\\.backup"
      fi

      if [ "$skip" = "false" ] && [ "$skip_all" = "false" ]; then
        link_file "$source" "$dest"
      else
        successn "skipped $source"
      fi

    else
      link_file "$source" "$dest"
    fi

  done
}

dotfiles_rm () {
  local -r dotfiles=$(dotfiles_ls)

  for source in $dotfiles
  do
    local dest="$HOME/.$(basename \""${source%.*}"\")"
    if [ -f "$dest" ] || [ -d "$dest" ]; then
      remove_file "$dest"
    fi
  done
}

#
# Fonts
#
fonts_ls () {
  find "FILES_ROOT/fonts" -name '*.otf'
}

fonts () {
  infon 'installing fonts . . .'
  local -r fonts=$(fonts_ls)

  for font in $fonts
  do
  	dest="$HOME/Library/Fonts/$(basename "${font}")"
    
    if ! [ -f "$dest" ]; then
      copy_file "$font" "$dest"
    fi
  done
}

fonts_rm () {
  local -r fonts=$(fonts_ls)

  for font in $fonts
  do
  	dest="$HOME/Library/Fonts/$(basename "${font}")"
    
    if [ -f "$dest" ]; then
      remove_file "$dest"
    fi
  done
}

#
# Gitconfig
#
gitconfig_path () {
  echo "$DOT_FILES/git/gitconfig.symlink"	
}

gitconfig () {
  local -r path=$(gitconfig_path)

  if ! [ -f "$path" ]; then
    infon 'setup gitconfig'

    # Default to existing configuration when present
    if git config user.name &>/dev/null; then
      GIT_NAME="$(git config user.name)"
    else
      usern ' - What is your git display name?'
      read -re GIT_NAME
    fi

    if git config user.name &>/dev/null; then
      GIT_EMAIL="$(git config user.email)"
    else
      user ' - What is your git email?'
      readn -re GIT_EMAIL
    fi
    
    if git config github.user &>/dev/null; then
      GITHUB_USER="$(git config github.user)"
    else
      usern ' - What is your Github username?'
      read -re GITHUB_USER
    fi

    # Generate gitconfig from template
    sed -e "s/GIT_NAME/$GIT_NAME/g" \
        -e "s/GIT_EMAIL/$GIT_EMAIL/g" \
        -e "s/GITHUB_USER/$GITHUB_USER/g" \
        git/gitconfig.template > git/gitconfig.symlink

    successn 'generated gitconfig'
  else
    infon "skipped gitconfig: $(path) exists"
    echo ''
  fi
}

gitconfig_rm() {
  remove_file $(gitconfig_path)
}
