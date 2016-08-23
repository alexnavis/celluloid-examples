#! /usr/bin/env ruby

ENV['LOG_LEVEL'] ||= 'info'

libs = []
libs << './lib/config/boot.rb'

command_line = []
command_line << 'irb'
command_line << libs.inject('') { |acc, lib| acc + %( -r "#{lib}") }
command_line << '--simple-prompt'
command = command_line.join(' ')

puts 'Welcome'

env_file = '.env'
if File.exists?(env_file)
  exec "source #{env_file};#{command}"
else
  exec "#{command}"
end
