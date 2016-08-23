require 'celluloid/current'

class ParentActor
  include Celluloid

  def initialize(crash_me = false)
    puts 'initialize parent actor'
    async.setup(crash_me) # without async - it crashes the parent celluloid-examples as well
  end

  def setup(crash_me)
    @child = Celluloid::Actor[:child]
    link @child
    async.start if crash_me
    # other possibilities
    # @minion = Minion.new_link(false, true) # `sleep': No live threads left. Deadlock? (fatal)
  end

  def start
    every(2) { puts 'working' }
    every(5) { raise 'parent error' }
  end
end