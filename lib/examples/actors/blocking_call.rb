require 'celluloid/current'

class BlockingCall
  include Celluloid

  def initialize
    puts 'called in init crash test'
    @queue = Queue.new
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

# BlockingCall.supervise as: :init
BlockingCall.pool as: :init, size: 2
sleep