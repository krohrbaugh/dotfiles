#!/usr/bin/env ruby
# -*- ruby -*-

libs = %w(looksee wirble interactive_editor)

if RUBY_VERSION < "1.9"
  libs.unshift 'rubygems'
end

libs.each do |lib|
  begin
    require lib
  rescue LoadError => e
    puts "Failed to load #{lib}: #{e.message}"
  end
end
