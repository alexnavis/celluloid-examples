require 'celluloid/current'

class Minion
  include Celluloid

  def initialize
    puts 'init'
  end

  def hello
    puts 'hello'
  end
end

actor = Minion.new
actor.hello
actor.async.hello
sleep

# Output
# init
# hello
# hello