# module MuckEngine # :nodoc:
#   module Controllers # :nodoc:
#     module Matchers
#    
#       # Ensure a login is required for the given action
#       # Parameters:
#       #     action      - Name of the action in the control that should require a login ie "index"
#       #     method      - Method to use to call the action ie :post, :get
#       #     login_url   - Optional url the user should be redirected to if they aren't logged in.  Defaults to '/login'
#       #
#       # Example:
#       #           should_require_login 'index', :get, '/signup'
#       def require_login(action, method, login_url = 'login')
#         RequireLoginMatcher.new(action, method, self, login_url)
#       end
#       
#       class RequireLoginMatcher
#         
#         def initalize(action, method, context, login_url)
#           @action = action
#           @method = method
#           @context = context
#           @login_url = login_url
#         end
#         
#         def matches?(controller)
#           @controller = controller
#           requires_login?
#         end
#         
#         def in_context(context)
#           @context = context
#           self
#         end
#         
#         def failure_message
#           "Expected a #{@method} to #{@action} to require login"
#         end
# 
#         def description
#           "require login #{@action}"
#         end
#         
#         private
#         
#           def requires_login?
#           end
#       end
#       
#     end
#   end
# end
# 
# 
# # Ensure a login is required for the given actions
# # Parameters:
# #             Pass the following as arguements
# #             :login_url => '/login'  -- url the user should be redirected to if they aren't logged in.  Defaults to '/login'
# #             :get => 'index'
# #             :post => 'create'
# #
# # Example:
# #           should_require_login :login_url => '/signup', :get => 'index'
# def should_require_login(*args)
#   args = Hash[*args]
#   login_url = args.delete :login_url
#   login_url ||= '/login'
#   
#   args.each do |action, verb|
#     should "Require login for '#{action}' action" do
#       if [:put, :delete].include?(verb) || [:edit, :show].include?(action)  # edit, show, put and delete require an id even if it is a bogus one
#         send(verb, action, :id => 1)
#       else
#         send(verb, action)
#       end
#       assert_redirected_to(login_url)
#     end
#   end
# end