require 'celluloid/current'

class ParentActorTest
end
#ChildActor.supervise as: :child, args: [false, true] # this combination make the child actor not working
ChildActor.supervise as: :child, args: [true, true]
ParentActor.supervise as: :parent_actor, args: [true]
sleep
