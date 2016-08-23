require 'celluloid/current'

class SiblingMinionActorTest
end
#Minion.supervise as: :minion, args: [false, true] # this combination make the minion not working
Minion.supervise as: :minion, args: [true, true]
SiblingMinionActor.supervise as: :parent_minion_actor, args: [true]
sleep
