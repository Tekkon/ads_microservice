require 'rubygems'

ENV['RACK_ENV'] ||= 'test'
require_relative '../config/environment.rb'

require 'spec_helper'

abort("You're running specs in production mode.") if Application.environment == :production
Dir[Application.root.concat('/spec/support/**/*.rb')].sort.each { |f| require f }

Object.send(:remove_const, :ActiveRecord)

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include RouteHelpers, type: :routes
  config.include ClientHelpers, type: :client
end
