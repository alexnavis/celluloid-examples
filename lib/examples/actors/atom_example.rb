require 'celluloid/current'

class Actor1
  include Celluloid

  def perform
    puts 'Actor 1'
    puts Celluloid::Actor[:atom_actor2].perform
  end

  def satisfied?
    true
  end
end

class Actor2
  include Celluloid

  def perform
    if Celluloid::Actor[:atom_actor1].satisfied?
      puts 'Actor 2 completed'
    end
  end
end

Actor1.supervise as: :atom_actor1
Actor2.supervise as: :atom_actor2
Celluloid::Actor[:atom_actor1].perform
sleep