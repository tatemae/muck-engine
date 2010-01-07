
ActionController::Base.send :include, ActionController::MuckApplication
ActiveRecord::Base.send :include, ActiveRecord::MuckModel
ActionController::Base.send :helper, MuckEngineHelper

I18n.load_path += Dir[ File.join(File.dirname(__FILE__), '..', 'locales', '*.{rb,yml}') ]
I18n.load_path += Dir[ File.join(File.dirname(__FILE__), '..', 'rails_i18n', '*.{rb,yml}') ]

Mime::Type.register "application/rdf+xml", :rdf
Mime::Type.register "text/xml", :opml
Mime::Type.register "text/javascript", :pjs
Mime::Type.register_alias "text/html", :iphone

# Use to determine whether or not ssl should be used
def muck_routes_protocol
  @@routes_protocol ||= GlobalConfig.enable_ssl ? (ENV["RAILS_ENV"] =~ /(development|test)/ ? "http" : "https") : 'http'
end