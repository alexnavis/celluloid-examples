require 'celluloid/current'

class SupervisionWorker
  include Celluloid

  def initialize(is_async = true)
    puts "initialize SupervisionWorker #{is_async}"
    async.start if is_async
    start unless is_async
  end

  def start
    loop do
      @times = (@times || 0) + 1
      raise 'error in get_data' if @times % 2 == 0
      puts "minion::get_data >> #{@times}"
      sleep 1
    end
  end
end

class MasterContainerCrash < Celluloid::Supervision::Container
  supervise SupervisionWorker, as: :supervision_worker

  def initialize(start_loop = false)
    super(start_loop)
    puts 'initialize master'
    async.start_loop if start_loop
  end

  def start_loop
    puts 'started master'
    every(1) { puts 'group working' }
    every(3) { raise 'master loop error' }
    # raise 'master loop error'
  end
end
MasterContainerCrash.run args: [true]

# Doesn't revive for this kind of crash
# container = MasterContainerCrash.run! args: [true]
# container.async.start_loop
# sleep
