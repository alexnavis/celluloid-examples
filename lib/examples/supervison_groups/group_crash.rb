require 'celluloid/current'

class SupervisionWorker
  include Celluloid

  def initialize
    puts 'initialize SupervisionWorker '
    @crash_actor = Celluloid::Actor[:supervision_worker2]
    puts "#{@crash_actor}"
    # link(@crash_actor)
    async.start
  end

  def start
    @crash_actor.async.sync
    loop do
      puts 'minion::get_data >> '
      sleep 1
    end
  end
end

class SupervisionWorkerCrash
  include Celluloid

  def initialize
    puts "initialize 2"
    async.start
  end

  def start
    loop do
      sleep 1
      @times = (@times || 0) + 1
      raise 'error in get_data' if @times % 2 == 0
    end
  end
end

class GroupCrash < Celluloid::Supervision::Container
  supervise SupervisionWorkerCrash, as: :supervision_worker2
  supervise SupervisionWorker, as: :supervision_worker
end
GroupCrash.run

# Doesn't revive for this kind of crash
# container = MasterContainerCrash.run! args: [true]
# container.async.start_loop
# sleep
