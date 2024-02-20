module RabbitMq
  extend self

  @mutex = Mutex.new

  # One connection for all threads.
  def connection
    @mutex.synchronize do
      @connection ||= Bunny.new.start
    end
  end

  # Each thread has its own channel.
  def channel
    Thread.current[:rabbitmq_channel] ||= connection.create_channel
  end
end
