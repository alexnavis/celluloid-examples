require 'celluloid/current'

class ChildWorker
  include Celluloid

  def initialize
    create_connection
  end

  def create_connection
    raise 'error'
  end
end

class ChildInitCrashInContainerTest < Celluloid::Supervision::Container
  supervise ChildWorker, as: :child

  def initialize
    super
    puts 'initialize master'
  end

end

ChildInitCrashInContainerTest.run
# Will crash the whole