#
# Directory bookmarks
#   Adds named directory to ZSH command hash, if the directory exists.
#
# Use:
#   1. Define bookmarks in bookmark files (one bookmark per line)
#       # ./bookmarks/global
#       name=path/to/bookmark
#   2. Use bookmarks in shell:
#       $ ~name # => cd path/to/bookmark
#   3. There is no step 3
#
# To add bookmarks but exclude them from git, create a hidden file:
#
#   touch bookmarks/.secret
#
setopt autocd

typeset -A dir_bookmarks
dir_bookmarks=()

typeset -U bookmark_files
bookmark_files=($ZSH/bookmarks/(.*|*))

# Load bookmarks, excluding this init script
for file in ${${bookmark_files:#*/init.zsh}}
do
  for line in `cat $file`
  do
    bookmark=(${(s/=/)line})
    dir_bookmarks[$bookmark[1]]=${(e)bookmark[2]}
  done
done

for bookmark in ${(k)dir_bookmarks}
do
  bookmark_path=$dir_bookmarks[$bookmark]
  if [[ -d "$bookmark_path" ]]
  then
    hash -d $bookmark=$bookmark_path
  else
    echo "$bookmark_path not found; $bookmark bookmark not set!"
  fi
done

unset bookmark_files
unset dir_bookmarks
