require 'will_paginate'
require 'validation_reflection'
require 'overlord'

require 'muck-engine/config'
require 'muck-engine/flash_errors'
require 'muck-engine/json'
require 'muck-engine/form_builder'
require 'muck-engine/models/country'
require 'muck-engine/models/language'
require 'muck-engine/models/state'
require 'muck-engine/models/general'
require 'muck-engine/remote_photo_methods'
require 'muck-engine/mailers/general'
require 'muck-engine/controllers/application'
require 'muck-engine/controllers/ssl_requirement'
require 'muck-engine/engine'

# Use to determine whether or not ssl should be used
def muck_routes_protocol
  #@@routes_protocol ||= 'http' if local_request?
  @@routes_protocol ||= MuckEngine.configuration.enable_ssl ? (ENV["RAILS_ENV"] =~ /(development|test)/ ? "http" : "https") : 'http'
end