#!/usr/bin/env ruby
# -*- ruby -*-

# Patches PG Juniper .pac file (Mac OS X)
exit unless RUBY_PLATFORM =~ /darwin/i

PAC_FILE = '/tmp/nc.pac'

pac_contents = File.read(PAC_FILE)
pac_contents = pac_contents.gsub(
  /return FindServerProxy/, 'return FindClientProxy')
File.open(PAC_FILE, 'w') { |file| file.puts pac_contents }

puts "Succesfully patched #{PAC_FILE}"
