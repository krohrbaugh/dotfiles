#
# Git aliases
#
alias gs="git status -sb"
alias gd="git diff"
alias gc="git commit"
alias gl="git pull --prune"
alias grb="git rebase -i @{u}"
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"