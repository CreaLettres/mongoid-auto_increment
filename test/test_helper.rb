require 'bundler/setup'
require 'simplecov'
SimpleCov.configure do
  add_filter '/test/'
end
SimpleCov.start if ENV['COVERAGE']

require 'minitest/autorun'
require 'mongoid'

Mongo::Logger.logger = Logger.new(File.open(File.expand_path('../../log/test.log', __FILE__), 'a+'))

require File.expand_path("../../lib/mongoid-auto_increment", __FILE__)

Mongoid.load!("#{File.dirname(__FILE__)}/mongoid.yml", "test")

Dir["#{File.dirname(__FILE__)}/models/*.rb"].each { |f| require f }

ActiveSupport::TestCase.test_order = :random

class BaseTest < ActiveSupport::TestCase
  def teardown
    Mongoid.default_client.use('mongoid_auto_increment_test').database.drop
  end
end

