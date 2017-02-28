require 'celluloid/current'

class BlockingCallFuture
  include Celluloid

  def initialize
    puts 'called in init crash test'
    @queue = Queue.new
    async.start
  end

  def start
    every(1) { puts ' Every 1 second I do something' }
    every(5) { @queue << 1 }

    loop do
      puts 'waiting for queue item'
      begin
        puts "Queue item#{Celluloid::Future.new { @queue.pop }.value}"
      rescue
        sleep 1
        redo
      end
    end

  end
end

BlockingCallFuture.supervise as: :init
sleep