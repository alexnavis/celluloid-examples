require 'celluloid/current'

class ChildActor
  include Celluloid

  def initialize(is_async = true, start = true)
    puts "initialize child actor #{is_async}, #{start}"
    if start
      async.start if is_async
      start unless is_async
    end
  end

  def start
    loop do
      @times = (@times || 0) + 1
      raise 'error in get_data' if @times % 2 == 0
      puts "child_actor::get_data >> #{@times}"
      sleep 1
    end
  end
end