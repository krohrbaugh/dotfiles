#!/usr/bin/env ruby
# -*- ruby -*-

# Detects system proxy settings for shell use (Mac OS X)
exit unless RUBY_PLATFORM =~ /darwin/i

require 'yaml'

class ProxySettings
  def initialize
    raw_settings = `scutil --proxy`
    raw_settings.gsub! /\s*\<\w+\>\s+\{|\s+\}/, ''
    @settings = YAML::load(raw_settings)
  rescue
    @settings = {}
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
      exceptions_list = @settings['ExceptionsList']

      if exceptions_list
        exceptions_list.each do |key, value|
          exceptions << value.sub(/\*/, '')
        end
      end
      exceptions.join(',')
    end
end

opt = ARGV[0].downcase
settings = ProxySettings.new

puts case opt
when '--proxy'
  settings.http_proxy
when '--no_proxy'
  settings.exceptions_list
when '--all'
  "#{settings.http_proxy}|#{settings.exceptions_list}"
else
  "unknown argument"
end
