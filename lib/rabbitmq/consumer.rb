require 'bunny'

class Consumer
  def initialize(queue:)
    @connection = Bunny.new.start
    @channel = @connection.create_channel
    @queue = @channel.queue(queue)
  end

  def start
    @queue.subscribe do |delivery_info, properties, payload|
      puts "Received: #{payload}"
    end
  end
end

Consumer.new(queue: 'tasks').start
puts 'Consumer started'

loop { sleep 3 }
