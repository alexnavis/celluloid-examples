require 'celluloid/current'

class MultiCrash
  include Celluloid

  def initialize
    puts 'called in init crash test'
  end

  def start
    raise 'error'
  end
end

MultiCrash.supervise as: :init
loop do
  begin
    Celluloid::Actor[:init].start if Celluloid::Actor[:init]
  rescue Exception => e
    puts e.inspect
  end
end
