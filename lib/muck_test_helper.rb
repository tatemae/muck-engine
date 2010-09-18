require 'rails/test_help'
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

class ActiveSupport::TestCase
  
  include Authlogic::TestCase
  setup :activate_authlogic
    
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false
  
  def ensure_flash(val)
    assert_contains flash.values, val, ", Flash: #{flash.inspect}"
  end
  
  def login_as(user)
    success = UserSession.create(user)
    if !success
      errors = user.errors.full_messages.to_sentence
      message = 'User has not been activated' if !user.active?
      raise "could not login as #{user.to_param}.  Please make sure the user is valid. #{message} #{errors}"
    end
    UserSession.find
  end
  
  def assure_logout
    user_session = UserSession.find
    user_session.destroy if user_session
  end
  
end