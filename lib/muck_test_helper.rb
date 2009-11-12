require 'test_help'
gem 'factory_girl'
require 'factory_girl'
require 'mocha'
require 'ruby-debug'
require 'redgreen' rescue LoadError
require File.join(File.dirname(__FILE__), 'test', 'muck_factories')
require File.join(File.dirname(__FILE__), 'test', 'muck_test_methods')
require File.join(File.dirname(__FILE__), 'test', 'shoulda_macros', 'controller')
require File.join(File.dirname(__FILE__), 'test', 'shoulda_macros', 'forms')
require File.join(File.dirname(__FILE__), 'test', 'shoulda_macros', 'models')
require File.join(File.dirname(__FILE__), 'test', 'shoulda_macros', 'pagination')
require File.join(File.dirname(__FILE__), 'test', 'shoulda_macros', 'plugins')

