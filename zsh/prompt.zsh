#!/usr/bin/env bash
#
# Prompt configuration
#
# NOTE: Requires colors built-in to be loaded.
autoload -Uz colors; colors

if (( $+commands[git] ))
then
  git_cmd="$commands[git]"
else
  git_cmd="/usr/bin/git"
fi

git_status () {
  # TODO: Resume here: need to determine whether to show dirty/unpushed based on config
  # and short-circuit before the call to git status
  if [ $(git rev-parse --is-inside-work-tree 2>/dev/null) ]; then
    echo " on $(git_dirty)$(git_branch)%{$reset_color%}$(need_push)"
  fi
}

git_branch() {
  echo $(git rev-parse --abbrev-ref HEAD)
}

git_dirty () {
  git_status=$(git status --porcelain)
  if [ -z "$git_status" ]; then
    # Clean
    echo "%{$fg_bold[green]%}"
  else
    # Dirty
    echo "%{$fg_bold[red]%}"
  fi
}

# git_dirty() {
#   st=$(git status 2>/dev/null | tail -n 1)
#   if [[ $st == "" ]]
#   then
#     echo ""
#   else
#     if [[ "$st" =~ ^nothing ]]
#     then
#       echo "on %{$fg_bold[green]%}$(git_branch)%{$reset_color%}"
#     else
#       echo "on %{$fg_bold[red]%}$(git_branch)%{$reset_color%}"
#     fi
#   fi
# }

# git_prompt_info () {
#  ref=$($git_cmd symbolic-ref HEAD 2>/dev/null) || return
#  echo "${ref#refs/heads/}"
# }

unpushed () {
  $(git cherry -v @{upstream} 2>/dev/null)
}

need_push () {
  if [ -z "$(unpushed)" ]; then
    echo ""
  else
    echo " with %{$fg_bold[magenta]%}unpushed%{$reset_color%} "
  fi
}

user_info() {
  echo "%{$fg[green]%}%n@%m%{$reset_color%}"
}

# This keeps the number of todos always available the right hand side of my
# command line. I filter it to only count those tagged as "+next", so it's more
# of a motivation to clear out the list.
todo(){
  if (( $+commands[todo.sh] ))
  then
    num=$(echo $(todo.sh ls +next | wc -l))
    let todos=num-2
    if [ $todos != 0 ]
    then
      echo "$todos"
    else
      echo ""
    fi
  else
    echo ""
  fi
}

directory_name(){
  echo "%{$fg_bold[cyan]%}%1/%{$reset_color%}"
}

# export PROMPT=$'$(user_info) in $(directory_name) $(git_dirty)$(need_push)\n› '
export PROMPT=$'$(user_info) in $(directory_name)$(git_status)\n› '

precmd() {
  title "zsh" "%m" "%55<...<%~"
  print
}

unset git_cmd
