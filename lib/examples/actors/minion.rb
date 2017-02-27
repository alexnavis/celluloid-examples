require 'celluloid/current'

class Minion
  include Celluloid

  def initialize
    @bananas = []
  end

  def add
    @bananas << 1
  end

  def print
    puts "Count: #{@bananas.size}"
  end
end

Minion.supervise as: :minion
10.times { Thread.new { Celluloid::Actor[:minion].add } }
sleep 2
Celluloid::Actor[:minion].print # Count: 10
