class MinionMasterContainerCrash
end
MinionMasterContainer.run args: [true]

# Doesn't revive for this kind of crash
# container = MinionMasterContainer.run! args: [true]
# container.async.start_loop
# sleep
