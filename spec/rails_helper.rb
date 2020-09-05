require 'spec_helper'
require 'simplecov'
SimpleCov.start 'rails' do
  add_filter ['app/jobs/application_job.rb',
              'app/mailers/application_mailer.rb',
              'app/channels/application_cable',
              'app/admin']
  add_group 'Decorators', 'app/decorators'
end

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

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

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
  Capybara.default_driver = :selenium_chrome
  Capybara.register_driver :poltergeist_debug do |app|
    Capybara::Poltergeist::Driver.new(app, inspector: true)
  end
  Capybara.default_max_wait_time = 10
  Capybara.javascript_driver = :poltergeist_debug
  Capybara::Screenshot.prune_strategy = :keep_last_run
end
