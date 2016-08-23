require 'celluloid/current'

class ContainerWentMissing
  include Celluloid

  def initialize
    puts 'init'
    async.start
  end

  def start
    raise 'error'
  end

end

ContainerWentMissing.supervise as: :init

loop do
  begin
    puts "Inside loop: #{Celluloid::Actor[:init]}"
  rescue Exception
    puts '\n#########################\n\n'
    sleep 5
  end
end
