$:.reject! { |e| e.include? 'TextMate' }
ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")

require 'test_help'
require 'ruby-debug'
require 'authlogic/test_case'
require 'muck_test_helper'
require 'pp'

class ActiveSupport::TestCase
  include MuckTestMethods
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false
  
  include Authlogic::TestCase
  
  def login_as(user)
    success = UserSession.create(user)
    if !success
      errors = user.errors.full_messages.to_sentence
      message = 'User has not been activated' if !user.active?
      raise "could not login as #{user.to_param}.  Please make sure the user is valid. #{message} #{errors}"
    end
    UserSession.find
  end
  
end