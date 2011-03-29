#!/usr/bin/env ruby
# -*- ruby -*-

#
# Alias Looksee's :ls method to :m
#
if defined? ls
  alias :m :ls
  usage "m", "Lists methods defined on the argument object and their sources"
end
