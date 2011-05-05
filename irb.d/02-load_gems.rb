#!/usr/bin/env ruby
# -*- ruby -*-
module IRBExtensions
  # Load a gem into IRB regardless of Bundler trickery. This method leaves
  # $LOAD_PATH altered, in order to allow #autoload to work properly.
  #
  #   Inspired by:
  #     https://gist.github.com/955611
  #     https://gist.github.com/932231
  #
  # IRB.require_gem 'looksee'
  # IRB.require_gem 'awesome_print', :as => 'ap'
  def require_gem(name, options = {})
    name = name.to_s
    require_as = (options[:as] || options['as'] || name).to_s

    require require_as
  rescue LoadError => e
    gem_path = find_gem_path(name)

    $LOAD_PATH.unshift(gem_path) unless gem_path.nil?
    require require_as
  end

  private
    # Searches for the path of the specified gem, returning the lib path to the
    # most recent version of the gem, or nil if no matching path is found.
    def find_gem_path(name)
      candidates = []

      Gem.path.each do |path|
        glob = File.join(path, 'gems/*')

        Dir.glob(glob) do |entry|
          basename = File.basename(entry)
          gemname, sep, version = basename.rpartition('-')

          if gemname == name
            libdir = File.expand_path(File.join(entry, 'lib'))
            class << libdir; attr_accessor(:gemname); attr_accessor(:version); end
            libdir.gemname = gemname
            libdir.version = version.scan(/\d+/).map {|digit| digit.to_i}
            candidates.push(libdir)
          end
        end
      end

      candidates.sort! {|a, b| a.version <=> b.version}
      candidates.last
    end
end
IRB.instance_eval { extend IRBExtensions } if defined?(IRB)

libs = %w(wirble looksee interactive_editor)
libs.unshift('rubygems')  if RUBY_VERSION < '1.9'

libs.each do |lib|
  begin
    IRB.require_gem lib
  rescue Exception => e
    puts "Failed to load #{lib}: #{e.message}"
  end
end
