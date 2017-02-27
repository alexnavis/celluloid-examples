require 'celluloid/current'

class Minion
  include Celluloid

  def initialize
    puts 'initialized minion'
    every(5) { raise 'crazy' }
  end

  def action
    puts "#{Thread.current.to_s} do minion work"
  end
end

class MasterMinionTest < Celluloid::Supervision::Container
  pool Minion, as: :minions, size: 2
end

MasterMinionTest.run!
5.times { Celluloid::Actor[:minions].action }
sleep
