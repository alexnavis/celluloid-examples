require 'celluloid/current'

fiber = Fiber.new do
  puts 'Do some work'
  Fiber.yield
  puts 'Completed'
end
puts 'Started Fiber'
fiber.resume
puts 'Suspended Fiber'
fiber.resume
