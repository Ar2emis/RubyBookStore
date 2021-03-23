# frozen_string_literal: true

Capybara.register_driver(:chrome) do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    # Enables access to logs with `page.driver.manage.get_log(:browser)`
    loggingPrefs: {
      browser: 'ALL',
      client: 'ALL',
      driver: 'ALL',
      server: 'ALL'
    }
  )

  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('window-size=1920,1080')

  # Run headless by default unless CHROME_HEADLESS specified
  # options.add_argument('headless') unless /^(false|no|0)$/.match?(ENV['CHROME_HEADLESS'])

  # Disable /dev/shm use in CI
  options.add_argument('disable-dev-shm-usage') if ENV['CI']

  options.add_argument('disable-gpu')

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    desired_capabilities: capabilities,
    options: options
  )
end

Capybara.configure do |config|
  config.always_include_port = true
  config.asset_host = 'http://localhost:3000'
  config.default_driver = :chrome
  config.enable_aria_label = true
  config.ignore_hidden_elements = true
  config.javascript_driver = :chrome
  config.server = :puma, { Silent: true }
  config.server_port = 54_321
  config.default_max_wait_time = 6
end

Capybara::Screenshot.prune_strategy = { keep: 20 }
Capybara::Screenshot.register_driver(:chrome) do |driver, path|
  driver.browser.save_screenshot(path)
end
