require 'celluloid/current'

class SupervisorActorHeirarchyTest < Celluloid::Supervision::Container
  # supervise SiblingMinionActor, as: :parent
  supervise SiblingMinionActor, as: :parent, args: [true]

end
Minion.supervise as: :minion, args: [true, true]
SupervisorActorHeirarchyTest.run
# container went missing

