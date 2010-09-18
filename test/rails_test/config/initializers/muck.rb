MuckEngine.configure do |config|
  
  # Global application values.  These are used to display the app name, send emails, and configure where system emails go.
  config.application_url = 'localhost:3000'     # Url of 
  config.application_name = 'Example App'       # Common name for your application.  i.e. My App, Billy Bob, etc
  config.from_email = 'support@example.com'     # Emails will come from this address i.e. noreply@example.com, support@example.com, system@example.com, etc
  config.from_email_name = 'Example App'        # This will show up as the name on emails.  i.e. support@example.com <Example>
  config.support_email = 'support@example.com'  # Support email for your application.  This is used for contact us etc.
  config.admin_email = 'admin@example.com'      # Admin email for your application
  config.customer_service_number = '1-800-'     # Phone number if you have one (optional)
  
  # Application settings
  config.growl_enabled = false                  # If true then notifications and errors will popup in an overlay div similar to 'growl' on the mac. This uses jGrowl which must be included in your layout
  
  # Email charset.  No need to change this unless you have a good reason to change the encoding.
  config.mail_charset = 'utf-8'

  # Email server configuration
  # Sendgrid is easy: https://sendgrid.com/user/signup
  config.email_server_address = "smtp.sendgrid.net"   # Email server address.  'smtp.sendgrid.net' works for sendgrid
  config.email_user_name = 'admin@example.com'        # Email server username
  config.email_password = 'password'                  # Email server password
  config.base_domain = 'example.com'                  # Basedomain that emails will come from
    
  # ssl
  config.enable_ssl = false # Enable ssl if you have an ssl certificate installed.  This will provide security between the client and server.
  
  # Google Analtyics Configuration.  This will enable Google Analytics on your site and will be used if your template includes:
  #                                  <%= render :partial => 'layouts/global/google_analytics' %>
  config.google_tracking_code = ""                    # Get a tracking code here: http://www.google.com/analytics/. The codes look like this: 'UA-9685000-0'
  config.google_tracking_set_domain = "example.com"   # Base domain provided to Google Analytics. Useful if you are using subdomains but want all traffic 
                                              # recorded into one account.
end