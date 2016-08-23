require 'celluloid/current'

class Minion
  include Celluloid

  def initialize(is_async = true, start = true)
    puts "initialize minion #{is_async}, #{start}"
    if start
      async.start if is_async
      start unless is_async
    end

  end

  def get_data
    @times = (@times || 0) + 1
    raise 'error in get_data' if @times % 2 == 0
    puts "minion::get_data >> #{@times}"
    [1, 2]
  end

  def start
    loop do
      get_data
      sleep 1
    end
  end
end