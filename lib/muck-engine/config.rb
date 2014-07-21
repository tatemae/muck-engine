require 'ostruct'

module MuckEngine

  def self.configuration
    # In case the user doesn't setup a configure block we can always return default settings:
    @configuration ||= Configuration.new
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration

    # Global application values.  These are used to display the app name, send emails, and configure where system emails go.
    attr_accessor :application_url          # Url of your application
    attr_accessor :application_name         # Common name for your application.  i.e. My App, Billy Bob, etc
    attr_accessor :from_email               # Emails will come from this address i.e. noreply@example.com, support@example.com, system@example.com, etc
    attr_accessor :from_email_name          # This will show up as the name on emails.  i.e. support@example.com <Example>
    attr_accessor :support_email            # Support email for your application.  This is used for contact us etc.
    attr_accessor :admin_email              # Admin email for your application
    attr_accessor :customer_service_number  # Phone number if you have one (optional)
    attr_accessor :mail_charset             # Email charset.  No need to change this unless you have a good reason to change the encoding.
    attr_accessor :enable_ssl               # Enable ssl if you have an ssl certificate installed.  This will provide security between the client and server.

    # Application configuration
    attr_accessor :local_jquery             # If true jquery will be loaded from the local directory. If false then it will be loaded from Google's CDN
    attr_accessor :growl_enabled            # If true then notifications and errors will popup in an overlay div similar to 'growl' on the mac. This uses jGrowl which must be included in your layout

    # Email server configuration
    attr_accessor :email_server_address     # Email server address.  'smtp.sendgrid.net' works for sendgrid - https://sendgrid.com/user/signup
    attr_accessor :email_user_name          # Email server username
    attr_accessor :email_password           # Email server password
    attr_accessor :base_domain              # Basedomain that emails will come from

    # Google Analtyics Configuration.  This will enable Google Analytics on your site and will be used if your template includes:
    #                                  <%= render :partial => 'layouts/global/google_analytics' %>
    attr_accessor :google_tracking_code       # Get a tracking code here: http://www.google.com/analytics/. The codes look like this: 'UA-9685000-0'
    attr_accessor :google_tracking_set_domain # Base domain provided to Google Analytics. Useful if you are using subdomains but want all traffic
                                              # recorded into one account.

    attr_accessor :required_text_mark       # Value to show to indicate a field is required. Default is '*'
    def muck_admin_nav_items
      @@muck_admin_nav_items ||= []
    end

    # Add an item to the main admin navigation menu
    # Paramters:
    # name:                 Name for the link
    # path:                 Url to link to
    # image:                Image for the link
    def add_muck_admin_nav_item(name, path, image = '', insert_at = -1)
      muck_admin_nav_items.insert(insert_at, OpenStruct.new(:name => name, :path => path, :image => image))
    end


    def muck_dashboard_items
      @@muck_dashboard_items ||= []
    end

    # Add an item to the admin dashboard
    # path:   Path to the partial
    # locals: Hash of values to pass as locals to the partial
    def add_muck_dashboard_item(path, locals = {}, insert_at = -1)
      muck_dashboard_items.insert(insert_at, OpenStruct.new(:path => path, :locals => locals))
    end

    def initialize
      self.application_url = 'localhost:3000'
      self.application_name = 'My App'
      self.from_email = 'support@example.com'
      self.from_email_name = 'Example App'
      self.support_email = 'support@example.com'
      self.admin_email = 'admin@example.com'
      self.customer_service_number = '1-800-'
      self.mail_charset = 'utf-8'
      self.email_server_address = "smtp.sendgrid.net"
      self.email_user_name = 'admin@example.com'
      self.email_password = 'password'
      self.base_domain = 'example.com'
      self.enable_ssl = false
      self.growl_enabled = false
      self.local_jquery = false
      self.required_text_mark = '*'

      self.google_tracking_code = ""
      self.google_tracking_set_domain = "example.com"

    end

  end
end