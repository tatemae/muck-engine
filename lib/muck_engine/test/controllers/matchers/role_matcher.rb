module MuckEngine # :nodoc:
  module Controllers # :nodoc:
    module Matchers
   
      # Ensure a role is required for the given action
      # Parameters:
      #     role          - Role require to access the url.
      #     action        - Name of the action in the control that should require a role ie "index"
      #     verb          - Method to use to call the action ie :post, :get
      #     flash_message - Flash message indicating that the user was denied access
      #     role_url      - Optional url the user should be redirected to if they aren't logged in.  Defaults to '/role'
      #
      # Example:
      #           it { should require_role 'index', :get, /access denied/i, '/signup' }
      def require_role(role, action, verb, flash_message = /permission/i, role_url = '/login')
        RequireRoleMatcher.new(role, action, verb, role_url, flash_message, self)
      end
      
      class RequireRoleMatcher
        
        def initialize(role, action, verb, role_url, flash_message, context)
          @role = role
          @action = action
          @verb = verb
          @role_url = role_url
          @context = context
          @flash_message = flash_message
        end
        
        def matches?(controller)
          @controller = controller
          requires_role?
        end
        
        def failure_message
          "Expected a #{@method} to #{@action} to require role #{@role}"
        end

        def description
          "require role #{@action}"
        end
        
        private
        
          def requires_role?
            response = @context.send(@verb, @action, :id => 1)
            @context.send(:assert_redirected_to, @role_url)
            if flash.values.any? {|value| value =~ @flash_message }
              true
            else
              false
            end
          end
          
          def flash
            return @flash if @flash
            flash_and_now = @controller.request.session["flash"].dup if @controller.request.session["flash"]
            flash         = @controller.send(:flash)

            @flash = if @now
              flash.keys.each {|key| flash_and_now.delete(key) }
              flash_and_now
            else
              flash
            end
          end
          
      end
      
    end
  end
end