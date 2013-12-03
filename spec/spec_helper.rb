require 'coveralls'
Coveralls.wear!

require 'spork'

Spork.prefork do

  ENV['RAILS_ENV'] ||= 'test'
  require File.expand_path('../../config/environment', __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'
  require 'capybara/poltergeist'

  Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
  ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

  Capybara.javascript_driver = :poltergeist

  RSpec.configure do |config|

    config.fixture_path = "#{::Rails.root}/spec/fixtures"
    config.use_transactional_fixtures = false
    config.infer_base_class_for_anonymous_controllers = false
    config.include Devise::TestHelpers, :type => :controller
    config.order = 'random'

    config.before(:suite) do
      DatabaseCleaner.strategy = :truncation
    end

    config.before(:each) do
      DatabaseCleaner.start
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end
  end
end
