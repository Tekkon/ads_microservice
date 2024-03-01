module RabbitMq
  extend self

  @mutex = Mutex.new

  # One connection for all threads.
  def connection
    @mutex.synchronize do
      @connection ||= Bunny.new(
        host: Settings.rabbitmq.host,
        username: Settings.rabbitmq.username,
        password: Settings.rabbitmq.password
      ).start
    end
  end

  # Each thread has its own channel.
  def channel
    Thread.current[:rabbitmq_channel] ||= connection.create_channel
  end

  def consumer_channel
    Thread.current[:rabbitmq_consumer_channel] ||=
      connection.create_channel(
        nil,
        Settings.rabbitmq.consumer_pool
      )
  end
end
