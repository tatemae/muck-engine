$:.reject! { |e| e.include? 'TextMate' }
ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
gem 'muck-engine'
require 'muck_test_helper'


class ActiveSupport::TestCase
  include MuckTestMethods
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false
end