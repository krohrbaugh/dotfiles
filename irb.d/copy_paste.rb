#!/usr/bin/env ruby
# -*- ruby -*-

def copy(str)
  IO.popen('pbcopy', 'w') { |f| f << str.to_s }
end
usage "copy", "Copy output to clipboard (OSX)"

def copy_history
  history = Readline::HISTORY.entries
  index = history.rindex("exit") || -1
  content = history[(index+1)..-2].join("\n")
  puts content
  copy content
end
usage "copy_history", "Copy history to clipboard (OSX)"

def paste
  `pbpaste`
end
usage "paste", "Paste clipboard contents"