require 'celluloid/current'
require 'benchmark'

TIMES = 200
class ThreadContextTest
  include Celluloid

  def test
    1000.times.map { |index| index + 1 }
    sleep 0.001
    "test_thread context - #{Thread.current.inspect}"
  end

  def test2
    TIMES.times do
      test
      # "test_thread context - #{Thread.current.inspect}"
    end
  end
end

class TestActor
  include Celluloid

  def initialize
  end

  def test1
    measure = Benchmark.measure do
      TIMES.times do
        Celluloid::Actor[:test_thread].test
      end
    end
    puts "#{Thread.current.inspect}::Measure in test1 : #{measure.real.inspect}"
  end

  def test2
    measure = Benchmark.measure do
      Celluloid::Actor[:test_thread].test2
    end
    puts "#{Thread.current.inspect}:: Measure in test2 : #{measure.real.inspect}"
  end
end

ThreadContextTest.supervise as: :test_thread
# TestActor.supervise as: :test_actor
# Celluloid::Actor[:test_actor].async.test
# Celluloid::Actor[:test_actor].async.test2

Celluloid::Actor[:test_actor] = TestActor.pool
10.times { Celluloid::Actor[:test_actor].async.test1; Celluloid::Actor[:test_actor].async.test2 }
sleep
