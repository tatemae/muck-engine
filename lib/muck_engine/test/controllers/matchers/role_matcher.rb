module MuckEngine # :nodoc:
  module Controllers # :nodoc:
    module Matchers
   
      # Ensure a role is required for the given action
      # Parameters:
      #     role        - Role require to access the url.
      #     action      - Name of the action in the control that should require a role ie "index"
      #     verb        - Method to use to call the action ie :post, :get
      #     role_url    - Optional url the user should be redirected to if they aren't logged in.  Defaults to '/role'
      #
      # Example:
      #           it { should require_role 'index', :get, '/signup' }
      def require_role(role, action, verb, role_url = 'login')
        RequireRoleMatcher.new(role, action, verb, role_url)
      end
      
      class RequireRoleMatcher
        
        def initialize(role, action, verb, role_url)
          @role = role
          @action = action
          @verb = verb
          @role_url = role_url
        end
        
        def matches?(controller)
          @controller = controller
          requires_role?
        end
        
        def failure_message
          "Expected a #{@method} to #{@action} to require role"
        end

        def description
          "require role #{@action}"
        end
        
        private
        
          def requires_role?
            response = @context.send(@verb, @action, :id => 1)
            ensure_flash(/permission/i)
            @context.send(:assert_redirected_to, @login_url)
            true
          end
      end
      
    end
  end
end