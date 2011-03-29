#!/usr/bin/env ruby
# -*- ruby -*-

#
# Define :m to use Looksee's :ls method
#
if defined? ls
  def m(*args)
    if block_given?
      obj = yield
    elsif args.empty?
      obj = self
    else
      obj = args[0]
    end
    obj.send :ls
  end
  usage "m", "Lists methods defined on the argument object and their sources"
end
