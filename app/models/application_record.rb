# frozen_string_literal: true

require 'yaml'
require 'active_record'
require 'dotenv'

Dotenv.load

db_config_file = File.open('db/config.yml')
db_config = YAML::load(db_config_file)
puts db_config[Rails.env]

ActiveRecord::Base.establish_connection(db_config[Rails.env])

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
