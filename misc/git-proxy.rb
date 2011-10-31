#!/usr/bin/env ruby
# -*- ruby -*-

#
# = Conditional Git Proxy
#
# This script allows you to tunnel Git traffic through a proxy when behind
# a militant proxy.
#
# == Requirements
# Ncat (installed with nmap) and Corkscrew (an http-proxy).
#
# Proxy settings should be exported to the PROXY environment variable
# in the form of '<proxy_host>:<proxy_port>'
#
# == Use
# Set the GIT_PROXY_COMMAND environment variable to the path to this script.
#
#   GIT_PROXY_COMMAND="$PATH_TO_SCRIPT"
#
require 'open3'

def detect_command(command)
  abort "Unable to find #{command}; cannot proxy Git" if `which #{command}`.empty?
  command
end

def detect_proxy
  proxy, proxy_port = (ENV['proxy'] || '').split(':')
  proxy_port = (proxy_port || '8080') unless proxy.nil?
  [proxy, proxy_port]
end

def requires_proxy?(dest_host, dest_port)
  timeout = 5
  ncat    = detect_command 'ncat'
  
  command = "#{ncat} -w #{timeout} -i 1 #{dest_host} #{dest_port}"
  Open3.popen3(command) { |stdin, stdout, stderr| stdout.gets.nil? }
end

proxy_host, proxy_port  = detect_proxy
tunnel                  = detect_command 'corkscrew'

dest_host               = ARGV[0]
dest_port               = ARGV[1]

# Uses proxy for Git, when necessary
if requires_proxy?(dest_host, dest_port)
  # Connect via proxy
  exec "#{tunnel} #{proxy_host} #{proxy_port} #{dest_host} #{dest_port}"
else
  # Connect direct
  exec "#{netcat} #{dest_host} #{dest_port}"
end
