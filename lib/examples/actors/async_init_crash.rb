require 'celluloid/current'


class AsyncInitCrash
  include Celluloid

  def initialize
    puts 'initialize async init'
    async.start
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

AsyncInitCrash.supervise as: :async_init_crash
sleep
