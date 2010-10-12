require 'authlogic/test_case'

require File.join(File.dirname(__FILE__), 'test', 'muck_factories')
require File.join(File.dirname(__FILE__), 'test', 'muck_test_methods')
require File.join(File.dirname(__FILE__), 'test', 'muck_test_definitions')

require 'muck_engine/rspec2'
# require File.join(File.dirname(__FILE__), 'test', 'shoulda_macros', 'controller.rb')
# require File.join(File.dirname(__FILE__), 'test', 'shoulda_macros', 'forms.rb')
# require File.join(File.dirname(__FILE__), 'test', 'shoulda_macros', 'models.rb')
# require File.join(File.dirname(__FILE__), 'test', 'shoulda_macros', 'pagination.rb')
# require File.join(File.dirname(__FILE__), 'test', 'shoulda_macros', 'plugins.rb')
# require File.join(File.dirname(__FILE__), 'test', 'shoulda_macros', 'scopes.rb')

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

RSpec.configure do |config|
  config.include(Authlogic::TestCase)
end