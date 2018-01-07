#!/bin/bash
#
# Generates/deletes gitconfig.symlink using gitconfig.template
source "${SCRIPT_ROOT}/shared/paths.sh"
source "${SCRIPT_ROOT}/shared/common.sh"

gitconfig_path="${DOTFILES_ROOT}/git/gitconfig.symlink"

generate_gitconfig () {
  if ! [ -f "$gitconfig_path" ]; then
    info 'setup gitconfig'

    # Default to existing configuration when present
    if git config user.name &>/dev/null; then
      GIT_NAME="$(git config user.name)"
    else
      user ' - What is your git display name?'
      read -e GIT_NAME
    fi

    if git config user.name &>/dev/null; then
      GIT_EMAIL="$(git config user.email)"
    else
      user ' - What is your git email?'
      read -e GIT_EMAIL
    fi
    
    if git config github.user &>/dev/null; then
      GITHUB_USER="$(git config github.user)"
    else
      user ' - What is your Github username?'
      read -e GITHUB_USER
    fi

    # Generate gitconfig from template
    sed -e "s/GIT_NAME/$GIT_NAME/g" \
        -e "s/GIT_EMAIL/$GIT_EMAIL/g" \
        -e "s/GITHUB_USER/$GITHUB_USER/g" \
        git/gitconfig.template > git/gitconfig.symlink

    success 'generated gitconfig'
  else
    info "skipped gitconfig: $(gitconfig_path) exists"
    echo ''
  fi
}

delete_gitconfig() {
  if [ -f "$gitconfig_path" ]; then
    remove_file $gitconfig_path
  fi
}
