module MuckEngine # :nodoc:
  module Controllers # :nodoc:
    module Matchers

      # Ensure a login is required for the given action
      # Parameters:
      #     action      - Name of the action in the control that should require a login ie "index"
      #     verb        - Method to use to call the action ie :post, :get
      #     login_url   - Optional url the user should be redirected to if they aren't logged in.  Defaults to '/login'
      #
      # Example:
      #           it { should require_login 'index', :get, '/signup' }
      def require_login(action, verb, login_url = '/login')
        RequireLoginMatcher.new(action, verb, login_url, self)
      end

      class RequireLoginMatcher

        def initialize(action, verb, login_url, context)
          @action = action
          @verb = verb
          @login_url = login_url
          @context = context
        end

        def matches?(controller)
          @controller = controller
          requires_login?
        end

        def failure_message
          "Expected a #{@action} to #{@action} to require login"
        end

        def description
          "require login #{@action}"
        end

        private

          def requires_login?
            response = @context.send(@verb, @action, :id => 1)
            @context.send(:assert_redirected_to, @login_url)
            true
          end
      end

    end
  end
end