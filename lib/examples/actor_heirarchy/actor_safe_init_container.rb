require 'celluloid/current'
require 'pry'

class ActorSafeInit
  include Celluloid

  def initialize
    begin
      puts 'Initialize'
      puts 'started failure'
      # wait 1
      sleep 1
      10000.times { }
      puts 'end sleep'
      # init_with_failures
    rescue Exception => e
      puts 'exception'
      self.async.call_error e
    end
    self.async.perform
  end

  def init_with_failures
    exclusive do

    end
    # raise 'error'
  end

  def call_error(e)
    # sleep 1
    puts 'raise error'
    raise e
  end

  def perform
    sleep 1
    puts  'in perform'
    raise 'eerror'
  end

end

class ActorAsyncSafeInit
  include Celluloid

  def initialize
    puts 'Initialize'
    100000.times { puts 'a' }
    # sleep 1
    async.init_with_failures
  end

  def init_with_failures
    exclusive do
      puts 'started failure'
      sleep 0.5
      puts 'end sleep'
      raise 'error'
      async.perform
    end
  end

  def perform
    puts 'in perform'
    raise 'error'
  end

end

class ActorSafeInitContainer < Celluloid::Supervision::Container
  # 5.times { |i| supervise type: ActorSafeInit, as: "actor_safe_init#{i}".to_sym }
  5.times { |i| supervise type: ActorAsyncSafeInit, as: "actor_async_safe_init#{i}".to_sym }
end

ActorSafeInitContainer.run
#
# loop do
#   begin
#     Celluloid::Actor[:actor_safe_init1].perform
#   rescue => e
#     puts "Exception: #{e.inspect}"
#   end
#   sleep 0.1
# end
