#!/bin/bash
#
# Sets up ~/Code directory

# shellcheck source=script/shared/paths.sh
source "${SCRIPT_ROOT}/shared/paths.sh"
# shellcheck source=script/shared/common.sh
source "${SCRIPT_ROOT}/shared/common.sh"

get_code_dir () {
  echo "${HOME}/Code"
}

setup_code_dir () {
  local code_dir

  code_dir=$(get_code_dir)

  if ! [ -d "$code_dir" ]; then
  	make_directory "${code_dir}"
  	make_directory "${code_dir}/personal"
  	link_file "${DOT_FILES}" "${code_dir}/personal/dotfiles"
  else
  	info "skipped creating Code directory: ${code_dir} exists\\n"
  fi
}

delete_code_dir () {
  local code_dir
  code_dir=$(get_code_dir)

  if [ -d "$code_dir" ]; then
  	rm -rf "$code_dir"
  	success "deleted Code directory"
  else
  	warn "skipped deleting Code directory: does not exist\\n"
  fi
}