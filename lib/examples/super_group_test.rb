require 'celluloid/current'

class FirstContainer < Celluloid::Supervision::Container
  supervise Minion, as: :minion

  def initialize(start_loop)
  #   super(start_loop)
    super
    puts 'initialize first container'
    async.start_loop if start_loop
  end

  def start_loop
    puts 'started first container'
    every(1) { puts 'first container working' }
    every(3) { raise 'first container loop error' }
  end
end


class SuperGroupTest < Celluloid::Supervision::Container

  def initialize
    container = FirstContainer.run! args:[true]
    # sync setup will crash the group
    async.setup container
  end

  def setup(container)
    @container = container
    link @container
  end

end


SuperGroupTest.run
