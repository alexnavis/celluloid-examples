require 'rubygems'
require 'bundler'

ACTOR_ENV = ENV['ACTOR_ENV'] ||= 'development' unless defined?(ACTOR_ENV)
Bundler.setup(:default, ACTOR_ENV)

require 'class_loader'
require 'celluloid'
require 'pry' if %w(development test).include? ACTOR_ENV
require 'semantic_logger'

autoload_dir File.join(File.dirname(__FILE__), '..', '..', 'lib')
directory = File.join(File.dirname(__FILE__), '..', '..', 'lib', 'examples')
autoload_dir directory
directories = Dir.entries(directory).select { |file| File.directory? File.join(directory, file) }.reject { |f| f == '.' || f == '..' }
directories.each { |directory| autoload_dir File.join(File.dirname(__FILE__), '..', '..', 'lib', 'examples', directory) }
