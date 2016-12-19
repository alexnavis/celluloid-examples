require 'celluloid/current'
require 'benchmark'

TIMES = 200
class ThreadCountTestActor
  include Celluloid

  def initialize
    async.start
  end

  def start
    loop do
      sleep 0.1
    end
  end
end

class ThreadCountTest < Celluloid::Supervision::Container
  5.times do |index|
    supervise type: ThreadCountTestActor, as: "container_worker#{index}".to_sym
  end
end



Thread.new {
  sleep 10
  puts "Threads: #{Thread.list.size}"
  Thread.list.each do |t|
    puts "Threads: #{t.inspect}"
  end
}
ThreadCountTest.run
# 5.times { |index|  ThreadCountTestActor.supervise(as: "container_worker#{index}".to_sym) }
sleep