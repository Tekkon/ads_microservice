Application.configure do |app|
  logdev =
    if app.environment == :production
      STDOUT
    else
      app.root.concat('/', Settings.logger.path)
    end

  logger = Ougai::Logger.new(logdev, level: Settings.logger.level)

  logger.before_log = lambda do |data|
    data[:service] = { name: Settings.app.name }
    data[:request_id] ||= Thread.current[:request_id]
  end

  app.set :logger, logger
end

Sequel::Model.db.loggers.push(Application.logger)
