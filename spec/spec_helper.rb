ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)

require 'rspec/rails'
require 'webmock/rspec'
require File.expand_path("../stubs.rb", __FILE__)
RSpec.configure do |config|
  config.include Mongoid::Matchers
  config.before :each do
     Mongoid.purge!
  end

end

