module MuckEngine
  module SslRequirement
    
    extend ActiveSupport::Concern
    
    included do
      before_filter :ensure_proper_protocol
    end
    
    module ClassMethods
      # Specifies that the named actions requires an SSL connection to be performed (which is enforced by ensure_proper_protocol).
      def ssl_required(*actions)
        write_inheritable_array(:ssl_required_actions, actions)
      end

      def ssl_allowed(*actions)
        write_inheritable_array(:ssl_allowed_actions, actions)
      end
    end
    
    protected
      # Only require ssl if we are in production
      def ssl_required?
        return ENV['SSL'] == 'on' ? true : false if defined? ENV['SSL']
        return false if local_request?
        return false if RAILS_ENV == 'test'
        ((self.class.read_inheritable_attribute(:ssl_required_actions) || []).include?(action_name.to_sym)) && (RAILS_ENV == 'production' || RAILS_ENV == 'staging')
      end
      

      def ssl_allowed?
        (self.class.read_inheritable_attribute(:ssl_allowed_actions) || []).include?(action_name.to_sym)
      end

    private
      def ensure_proper_protocol
        return true if ssl_allowed?

        if ssl_required? && !request.ssl?
          redirect_to "https://" + request.host + request.fullpath
          flash.keep
          return false
        elsif request.ssl? && !ssl_required?
          redirect_to "http://" + request.host + request.fullpath
          flash.keep
          return false
        end
      end
    
  end
end