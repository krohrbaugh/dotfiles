#!/usr/bin/env ruby
# -*- ruby -*-

#
# Wirble config
#
if Object.const_defined?(:Wirble) && Wirble.respond_to?(:init)
  Wirble.init
  
  colors = Wirble::Colorize.colors.merge({
    :comma => :red,
    :refers => :red,
    :open_array => :red,
    :close_array => :red
  })
  Wirble::Colorize.colors = colors  
  Wirble.colorize
end