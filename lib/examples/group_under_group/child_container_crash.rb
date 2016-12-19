require 'celluloid/current'

class Worker
  include Celluloid

  def initialize(is_async = true)
    puts "initialize worker #{is_async}"
    async.start if is_async
    start unless is_async
  end

  def start
    loop do
      @times = (@times || 0) + 1
      raise 'error in get_data' if @times % 2 == 0
      puts "worker::get_data >> #{@times}"
      sleep 1
    end
  end
end

class ChildContainer < Celluloid::Supervision::Container
  supervise Worker, as: :container_worker

  def initialize(start_loop)
    super
    puts 'initialize child container'
    async.start_loop if start_loop
  end

  def start_loop
    puts 'started first container'
    every(1) { puts 'first container working' }
    # every(3) { raise 'first container loop error' }
  end
end


class ChildContainerCrash < Celluloid::Supervision::Container

  def initialize
    container = ChildContainer.run! args:[true]
    # sync setup will crash the group, because accessing the container may result in error before restart
    async.setup container
  end

  def setup(container)
    @container = container
    link @container
  end
end

ChildContainerCrash.run
# Will work with restart happening for container inside container
