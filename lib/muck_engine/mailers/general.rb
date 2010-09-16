module MuckEngine
  module Mailers
    module General

      extend ActiveSupport::Concern
      
      included do
        layout 'email_default'
        default_url_options[:host] = MuckEngine.configuration.application_url
        default :from => "#{MuckEngine.configuration.from_email_name} <#{MuckEngine.configuration.from_email}>"
      end
      
    end
  end
end