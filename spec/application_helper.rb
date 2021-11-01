# frozen_string_literal: true

require 'spec_helper'
require 'active_job'

ENV['RACK_ENV'] ||= 'test'

require_relative '../config/environment'
require_all 'spec/support'

abort('You run test in production mode. Please don\'t do this!') if Application.environment == :production

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include RouteHelpers, type: :routes
  config.include ClientHelpers, type: :client
end
