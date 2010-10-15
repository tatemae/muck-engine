$:.reject! { |e| e.include? 'TextMate' }
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)

require 'muck_test_helper'
