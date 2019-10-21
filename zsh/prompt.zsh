#!/usr/bin/env bash
#
# Prompt configuration
#
# NOTE: Requires colors built-in to be loaded.
autoload -Uz colors; colors

prompt () (
  user_info () {
    echo "${FG[002]}%n@%m${FX[reset]}"
  }

  git_info () (
    cmd_current_branch () {
      git rev-parse --abbrev-ref HEAD
    }

    cmd_is_git_repo () {
      command -v git > /dev/null 2>&1 &&
        git rev-parse --is-inside-work-tree >/dev/null 2>&1
    }

    cmd_read_config () {
      config_type="$1"
      config_default="$2"
      config_setting="$3"
      git config --get --default "$config_default" --type "$config_type" \
        "$config_setting"
    }

    cmd_status () {
      git status --porcelain
    }

    cmd_unpushed_commits () {
      git cherry -v @{upstream} 2>/dev/null
    }

    dirty_file_count () {
      printf "%i" "$(cmd_status | wc -l)"
    }

    dirty_color () {
      # Default to unknown
      dirty_color="${FG[135]}"
      should_show_dirty=$(cmd_read_config "bool" "true" "shell.showdirty")
      if [ "$should_show_dirty" = "true" ]; then
        git_status=$(cmd_status)
        if [ "$(dirty_file_count)" -eq 0 ]; then
          dirty_color="${FG[010]}"
        else
          dirty_color="${FG[009]}"
        fi
      fi
      echo "$dirty_color"
    }

    branch_info () {
      echo "${FX[bold]}$(dirty_color)$(cmd_current_branch)${FX[reset]}"
    }

    unpushed_commit_count () {
      printf "%i" "$(cmd_unpushed_commits | wc -l)"
    }

    push_info () {
      should_show_push=$(cmd_read_config "bool" "true" "shell.showpush")
      if [ "$should_show_push" = "true" ]; then
        unpushed_commits=$(unpushed_commit_count)
        if [ "$unpushed_commits" -gt 0 ]; then
          echo " with ${FG[013]}$unpushed_commits unpushed${FX[reset]}"
        fi
      fi
    }

    if cmd_is_git_repo; then
      echo " on $(branch_info)$(push_info)"
    fi
  )

  path_info () {
    echo " in ${FG[012]}%1/${FX[reset]}"
  }

  printf "%s\n%s" \
    "$(user_info)$(path_info)$(git_info)" \
    "${FX[bold]}${FG[135]}› ${FX[reset]}"
)

PROMPT=$'$(prompt)'
export PROMPT


precmd() {
  title "zsh" "%m" "%55<...<%~"
  print
}
