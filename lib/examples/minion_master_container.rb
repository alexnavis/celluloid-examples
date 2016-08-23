require 'celluloid/current'
require 'actor/minion'

class MinionMasterContainer < Celluloid::Supervision::Container
  supervise Minion, as: :minion

  def initialize(start_loop = false)
    super(start_loop)
    puts 'initialize master'
    async.start_loop if start_loop
  end

  def start_loop
    puts 'started master'
    every(1) { puts 'group working' }
    every(3) { raise 'master loop error' }
    # raise 'master loop error'
  end
end

