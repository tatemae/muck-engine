require 'muck_engine/flash_errors'
require 'muck_engine/form_builder'
require 'muck_engine/config'
require 'muck_engine/populate'
require 'muck_engine/models/country'
require 'muck_engine/models/language'
require 'muck_engine/models/state'
require 'muck_engine/models/general'
require 'muck_engine/mailers/general'
require 'muck_engine/controllers/application'
require 'muck_engine/engine'


# Use to determine whether or not ssl should be used
def muck_routes_protocol
  @@routes_protocol ||= MuckEngine.configuration.enable_ssl ? (ENV["RAILS_ENV"] =~ /(development|test)/ ? "http" : "https") : 'http'
end