#!/usr/bin/env ruby
# -*- ruby -*-

# Detects proxy settings and generates a config file for the shell (OS X)
require 'yaml'
require 'erb'

class ProxySettings
  attr_reader :settings

  def initialize
    raw = `scutil --proxy`
    raw.gsub! /\s*\<\w+\>\s+\{|\s+\}/, ''
    @settings = YAML::load(raw)
  end

  def http_proxy_set?
    settings["HTTPEnable"] == 1
  end

  def http_proxy
    return "" unless http_proxy_set?
    "#{settings['HTTPProxy']}:#{settings['HTTPPort']}"
  end

  def exceptions_list
    @exceptions_list ||= generate_exceptions_list
  end

  private
    def generate_exceptions_list
      exceptions = []
      settings['ExceptionsList'].each do |key, value|
        exceptions << value.sub(/\*/, '')
      end
      exceptions.join(',')
    end
end

class ProxyConfigWriter
  def initialize
    @settings = ProxySettings.new
  end

  def write(path='/tmp')
    return unless RUBY_PLATFORM =~ /darwin/i

    template = ERB.new(DATA.read)
    @http_proxy = @settings.http_proxy
    @no_proxy = @settings.exceptions_list
    File.open("#{path}/proxy_config.sh", 'w+') do |file|
      file.write(template.result(binding))
    end
  end
end

ProxyConfigWriter.new.write

__END__
proxy=<%= @http_proxy %>
no_proxy=<%= @no_proxy %>

if [ -n "$proxy" ]; then
  export proxy
  export http_proxy="http://$proxy"
  export HTTP_PROXY="$http_proxy"
  export no_proxy
  export NO_PROXY="$no_proxy"
else
  unset proxy
  unset http_proxy
  unset HTTP_PROXY
  unset no_proxy
  unset NO_PROXY
fi
