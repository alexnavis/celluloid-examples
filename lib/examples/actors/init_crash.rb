require 'celluloid/current'

class InitCrash
  include Celluloid

  def initialize
    puts 'initialize init crash'

    after(0) { sleep 1; start }
    # future('start')
    # async.start
    # start
    # defer { start }
  end

  def start
    # loop do
    #   @times = (@times || 0) + 1
      raise 'error in get_data' #if @times % 2 == 0
      # puts "minion::get_data >> #{@times}"
      # sleep 1
    # end
  end
end
InitCrash.supervise as: :init_crash
sleep