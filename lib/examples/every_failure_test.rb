require 'celluloid/current'

class EveryFailureTest
  include Celluloid

  def initialize
    async.start
  end
  def start
    every(1) {
      puts 'Alex'
      raise 'error'
    }
  end

end

EveryFailureTest.supervise as: :test_process
sleep
