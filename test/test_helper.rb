ENV['RAILS_ENV'] ||= 'test'

require 'simplecov'
SimpleCov.start('rails')

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require 'capybara/rails'
require 'database_cleaner'
require 'factory_bot'
require 'ffaker'
require 'minitest/reporters'
require 'vcr'
require 'wrong'

# Capybara.register_driver :headless_chrome do |app|
  # options = Selenium::WebDriver::Chrome::Options.new(args: %w[no-sandbox headless disable-gpu disable-dev-shm-usage])

  # Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
# end

Capybara.server             = :puma
Capybara.javascript_driver = :headless_chrome
Capybara.javascript_driver  = :selenium_chrome_headless

DatabaseCleaner.strategy    = :transaction
Minitest::Reporters.use! Minitest::Reporters::ProgressReporter.new
Wrong.config.color

VCR.configure do |c|
  c.cassette_library_dir = 'test/vcr_cassettes'
  c.hook_into     :webmock
  c.ignore_hosts  '127.0.0.1', 'localhost'
end

class ActiveRecord::Base
  mattr_accessor :shared_connection
  @@shared_connection = nil

  def self.connection
    @@shared_connection || retrieve_connection
  end
end

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods
  include Wrong

  def before_setup
    super
    DatabaseCleaner.start
  end

  def after_teardown
    super
    DatabaseCleaner.clean
  end
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL

  def before_setup
    super
    ActiveRecord::Base.shared_connection  = ActiveRecord::Base.connection
    Capybara.current_driver               = Capybara.javascript_driver
  end

  def after_teardown
    super
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end
end

def parsed_current_rate(page)
  page.find('div#current-rate').text.match(/(?<== )\d+\.\d+/).to_s
end
