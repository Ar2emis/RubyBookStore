require 'spec_helper'
require_relative 'support/simplecov'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)

abort('The Rails environment is running in production mode!') if Rails.env.production?

require 'rspec/rails'
require 'capybara/rails'
require 'capybara/rspec'
require 'capybara-screenshot/rspec'
require 'shoulda-matchers'
require 'selenium-webdriver'
require 'site_prism'
require 'site_prism/all_there'
require 'faker'
require 'devise'
require 'aasm/rspec'
require 'rack_session_access/capybara'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.include FactoryBot::Syntax::Methods
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::IntegrationHelpers, type: :feature

  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    driven_by :chrome_headless
  end
end

['spec/support/config/*.rb', 'spec/support/helpers/*.rb'].each do |directory|
  Dir[Rails.root.join(directory)].sort.each { |file| require file }
end
