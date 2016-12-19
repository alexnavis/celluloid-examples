require 'celluloid/current'

class QueueActor
  include Celluloid

  def pop
    @queue ||= Queue.new
    @queue.pop
  end
end

class NonBlockingActor
  include Celluloid

  def initialize
    @queue = QueueActor.new_link
    puts 'called in init crash test'
    async.start
  end

  def start
    every(1) { puts ' Every 1 second I do something' }

    loop do
      puts 'waiting for queue item'
      begin
        @queue.pop
      rescue
        sleep 1
        redo
      end
    end

  end
end

NonBlockingActor.supervise as: :init
sleep