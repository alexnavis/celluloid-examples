#! /usr/bin/env ruby
exec "bundle exec ruby -e 'require \"./lib/config/boot.rb\"; puts #{ARGV[0]}'"
