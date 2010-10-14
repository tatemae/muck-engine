module MuckEngine
  module Mailers
    module General

      extend ActiveSupport::Concern
      
      included do
        layout 'email_default'
        default_url_options[:host] = MuckEngine.configuration.application_url
        default :from => default_from_email
      end
      
      module ClassMethods
        def default_from_email
          "#{MuckEngine.configuration.from_email_name} <#{MuckEngine.configuration.from_email}>"
        end
      end
      
    end
  end
end