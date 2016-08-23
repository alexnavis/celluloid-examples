require 'rubygems'
require 'bundler'

ACTOR_ENV  = ENV['ACTOR_ENV'] ||= 'development' unless defined?(ACTOR_ENV)
Bundler.setup(:default, ACTOR_ENV)

require 'class_loader'
require 'celluloid'
require 'pry' if %w(development test).include? ACTOR_ENV

autoload_dir File.join(File.dirname(__FILE__), '..', '..', 'lib')
autoload_dir File.join(File.dirname(__FILE__), '..', '..', 'lib', 'examples')

