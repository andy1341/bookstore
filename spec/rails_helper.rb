ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
if Rails.env.production?
  abort('The Rails environment is running in production mode!')
end
require 'simplecov'
SimpleCov.start
require 'spec_helper'
require 'rspec/rails'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
  config.include FeaturesHelper, type: :feature
  config.include CheckoutFeaturesHelper, type: :feature, checkout: true
  config.filter_rails_from_backtrace!
end
