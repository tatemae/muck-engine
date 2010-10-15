require 'rspec/core'
require 'rspec/mocks'
require 'rspec/expectations'
require 'rspec/rails'

require 'authlogic/test_case'

require 'rails/test_help'
include ActionDispatch::TestProcess

require File.join(File.dirname(__FILE__), 'test', 'muck_factories')
require File.join(File.dirname(__FILE__), 'test', 'muck_test_methods')
require File.join(File.dirname(__FILE__), 'test', 'muck_test_definitions')

require 'muck-engine/rspec2'

begin
  # turn off solr for tests
  class ActsAsSolr::Post
    def self.execute(request, core = nil)
      true
    end
  end
rescue NameError => ex
  puts "Solr not loaded.  Skipping ActsAsSolr mock"
  # solr isn't loaded. Just throw out the error
end

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.mock_with :rspec
  config.color_enabled = true
  config.include(RSpec::Mocks::Methods)
  config.include(Authlogic::TestCase)
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
end

