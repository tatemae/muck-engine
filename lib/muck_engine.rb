
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

class MuckEngine
  
  def self.muck_admin_nav_items
    @@muck_admin_nav_items
  end

  # Add an item to the main admin navigation menu
  # Paramters:
  # Name:    Name for the link
  # Path:    Url to link to
  # image:   Image for the link
  def self.add_muck_admin_nav_item(name, path, image = '')
    @@muck_admin_nav_items ||= []
    @@muck_admin_nav_items << OpenStruct.new(:name => name,
                                             :path => path,
                                             :image => image)
  end

end

# Add a link to admin home
MuckEngine.add_muck_admin_nav_item(I18n.translate('muck.engine.admin_home'), '/admin', '/images/admin/home.gif')