module ActionMailer

  module MuckMailer #:nodoc:

    module ClassMethods
    end

    # All the methods available to a record that has had <tt>acts_as_muck_user</tt> specified.
    module InstanceMethods
      
      protected
        def muck_setup_email(user)
          if user.is_a?(String)
            recipients  user
          else
            recipients  user.email
          end
          from          "#{GlobalConfig.from_email_name} <#{GlobalConfig.from_email}>"
          sent_on       Time.now
          content_type "text/html" # There is a bug in Rails that prevents multipart emails from working inside an engine.
                                   # See: https://rails.lighthouseapp.com/projects/8994-ruby-on-rails/tickets/2263-rails-232-breaks-implicit-multipart-actionmailer-tests#ticket-2263-22
        end
        
    end
    
    def self.included(receiver)
      receiver.extend ClassMethods
      receiver.class_eval do
        include InstanceMethods
      end
    end
      
  end
end