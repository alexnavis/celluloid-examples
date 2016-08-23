require 'celluloid/current'

class TestThreadContext
  include Celluloid

  def test_thread
    puts "test_thread context - #{Thread.current.inspect}"
  end
end
TestThreadContext.supervise as: :test_thread

class TestActor
  include Celluloid

  def test_thread
    puts "thread context in TestActor - #{Thread.current.inspect}"
    puts Celluloid::Actor[:test_thread].test_thread
  end
end
TestActor.supervise as: :test_actor
Celluloid::Actor[:test_actor].test_thread
