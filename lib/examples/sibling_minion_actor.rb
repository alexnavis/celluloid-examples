require 'celluloid/current'

class SiblingMinionActor
  include Celluloid

  def initialize(crash_me = false)
    puts 'initialize SiblingMinionActor'
    async.setup(crash_me) # without async - it crashes the parent celluloid-examples as well
  end

  def setup(crash_me)
    @minion = Celluloid::Actor[:minion]
    link @minion
    async.start if crash_me
    # other possibilities
    # @minion = Minion.new_link(false, true) # `sleep': No live threads left. Deadlock? (fatal)
  end

  def start
    every(2) { puts 'working' }
    every(5) { raise 'parent minion error' }
  end
end