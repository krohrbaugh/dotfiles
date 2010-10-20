#!/usr/bin/env ruby
# -*- ruby -*-

Dir["#{ENV['HOME']}/.irb.d/**/*.rb"].sort.each do |f|
  next if f =~ /_test.rb$/
  load f
end

load File.dirname(__FILE__) + '/.railsrc' if $0 == 'irb' && ENV['RAILS_ENV']
