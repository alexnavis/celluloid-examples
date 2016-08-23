require 'celluloid/current'

class SupervisorActorHeirarchyTest < Celluloid::Supervision::Container
  # supervise SiblingMinionActor, as: :parent
  supervise ParentActor, as: :parent, args: [true]

end
ChildActor.supervise as: :child, args: [true, true]
SupervisorActorHeirarchyTest.run
# container went missing

