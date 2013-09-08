#!/usr/bin/env ruby
# -*- ruby -*-

#
# = Conditional SSH Proxy
#
# This script allows you to tunnel SSH traffic through a proxy when behind
# a militant proxy that bars standard SSH traffic on port 22.
#
# == Requirements
# SSH, Netcat and Corkscrew (an http-proxy)
#
# == Use
# Within an ssh-config file (e.g., ~/.ssh/config):
#
#   Host *
#     ProxyCommand $PATH_TO_SCRIPT proxy.example.com 8080 %h %p
#
# Where proxy.example.com is the proxy host and 8080 is the port to tunnel
# traffic through.
#

def detect_netcat
  netcat = (`which nc`.empty? ? 'netcat' : 'nc')
  abort 'Unable to find netcat. Cannot detect SSH proxy.' if `which #{netcat}`.empty?
  netcat
end

# Uses proxy for SSH commands, when necessary
ssh     = 'ssh'
agent   = '-A' # Forward agent
tunnel  = 'corkscrew'
timeout = 8
netcat  = detect_netcat

# ProxyCommand ssh_proxy.rb <http-proxy-host> <proxy-port> %h %p
proxy       = ARGV[0]
proxy_port  = ARGV[1]
dest_host   = ARGV[2]
dest_port   = ARGV[3]

if `#{netcat} -w #{timeout} -z #{dest_host} #{dest_port}`.empty?
  # Connect via proxy
  exec "#{tunnel} #{proxy} #{proxy_port} #{dest_host} #{dest_port}"
else
  # Connect direct
  exec "#{netcat} #{dest_host} #{dest_port}"
end
