require 'capybara/rails'
require 'capybara/cucumber'

Capybara.default_driver = :selenium
Capybara.app_host = "http://localhost:8888"
Capybara.default_wait_time = 10

require "selenium-webdriver"
Selenium::WebDriver::Firefox::Binary.path = '/Applications/Firefox.app/Contents/MacOS/firefox-bin'

require 'factory_girl'
require 'muck_test_helper'

Before do
  # Create admin user:
  Rake::Task[ 'muck:users:create_admin' ].execute
  
  visit "/logout"
end
