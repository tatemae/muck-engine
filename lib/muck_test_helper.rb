require 'test_help'
gem 'factory_girl'
gem 'mocha'
gem 'shoulda'
# gem 'rspec', :lib => 'spec'
# gem 'rspec-rails', :lib => 'spec/rails'
gem 'treetop'
gem 'term-ansicolor'
gem 'cucumber', :version => '>=0.1.13', :lib => 'cucumber'
gem 'polyglot', :version => '>=0.2.4'
gem "rcov", :version => '>=0.8.1.2.0'
gem "webrat", :version => '>=0.4.4'

# only required if you want to use selenium for testing
#gem 'selenium-client', :lib => 'selenium/client'
#gem 'bmabey-database_cleaner', :lib => 'database_cleaner', :source => 'http://gems.github.com'

require 'shoulda'
require 'factory_girl'
require 'mocha'
require 'ruby-debug'

require 'redgreen' rescue LoadError
require File.join(File.dirname(__FILE__), 'test', 'muck_factories')
require File.join(File.dirname(__FILE__), 'test', 'muck_test_methods')
require File.join(File.dirname(__FILE__), 'test', 'muck_test_definitions')
require File.join(File.dirname(__FILE__), 'test', 'shoulda_macros', 'controller')
require File.join(File.dirname(__FILE__), 'test', 'shoulda_macros', 'forms')
require File.join(File.dirname(__FILE__), 'test', 'shoulda_macros', 'models')
require File.join(File.dirname(__FILE__), 'test', 'shoulda_macros', 'pagination')
require File.join(File.dirname(__FILE__), 'test', 'shoulda_macros', 'plugins')

begin
  # turn off solr for tests
  class ActsAsSolr::Post
    def self.execute(request)
      true
    end
  end
rescue NameError => ex
  puts "Solr not loaded.  Skipping ActsAsSolr mock"
  # solr isn't loaded. Just throw out the error
end