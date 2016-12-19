require 'celluloid/current'

class KillProcessTest
  # include Celluloid

  def test
    loop do
      puts 'Reading from console:'
      inp = gets
      puts "Read inputs: #{inp}"
      sleep 0.001
    end
  rescue Exception => e
    puts "Rescued : #{e}"
    retry
  end

end

# KillProcessTest.supervise as: :test_process
# Celluloid::Actor[:test_process].async.test
KillProcessTest.new.test
sleep
