$:.reject! { |e| e.include? 'TextMate' }
ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)

require 'rails/test_help'
require 'muck_test_helper'
require 'authlogic/test_case'

require File.expand_path(File.dirname(__FILE__) + '/factories')

class ActiveSupport::TestCase
  
  include Authlogic::TestCase
    
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