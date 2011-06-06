#!/usr/bin/env ruby
# -*- ruby -*-

# Detects system proxy settings for shell use (Mac OS X)
exit unless RUBY_PLATFORM =~ /darwin/i

require 'yaml'

class ProxySettings
  def initialize
    raw_settings = `scutil --proxy`
    raw_settings = <<-EOF
<dictionary> {
  FTPEnable : 1
  HTTPEnable : 1
  HTTPPort : 8080
  ExceptionsList : <array> {
    0 : *.local
    1 : 169.254/16
    2 : *.pg.com
    3 : *.dev
    4 : localhost
    5 : activate.adobe.com
    6 : practivate.adobe.com
    7 : 155.118.*
  }
  HTTPSPort : 8080
  FTPPassive : 1
  FTPProxy : naproxy.pg.com
  HTTPProxy : naproxy.pg.com
  FTPPort : 8080
  HTTPSEnable : 1
  HTTPSProxy : naproxy.pg.com
}
EOF
    raw_settings.gsub! /\s*\<\w+\>\s+\{|\s+\}/, ''
    @settings = YAML::load(raw_settings)
  end

  def http_proxy_set?
    @settings['HTTPEnable'] == 1
  end

  def http_proxy
    @http_proxy ||= (http_proxy_set? ? parse_http_proxy : "")
  end

  def http_proxy_port
    @settings['HTTPPort']
  end

  def exceptions_list
    @exceptions_list ||= parse_exceptions_list
  end

  private
    def parse_http_proxy
      proxy = @settings['HTTPProxy']
      proxy << ":#{http_proxy_port}" unless http_proxy_port.nil?
      proxy
    end

    def parse_exceptions_list
      exceptions = []
      @settings['ExceptionsList'].each do |key, value|
        exceptions << value.sub(/\*/, '')
      end
      exceptions.join(',')
    end
end

opt = ARGV[0].downcase
settings = ProxySettings.new

case opt
when 'proxy'
  msg = settings.http_proxy
when 'no_proxy'
  msg = settings.exceptions_list
else
  msg = 'unknown argument'
end

puts msg if RUBY_PLATFORM =~ /darwin/i
