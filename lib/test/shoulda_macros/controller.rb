module MuckControllerMacros

  # Ensure a login is required for the given actions
  # Parameters:
  #             Pass the following as arguements
  #             :login_url => '/login'  -- url the user should be redirected to if they aren't logged in.  Defaults to '/login'
  #             :get => 'index'
  #             :post => 'create'
  #
  # Example:
  #           should_require_login :login_url => '/signup', :get => 'index'
  def should_require_login(*args)
    args = Hash[*args]
    login_url = args.delete :login_url
    login_url ||= '/login'
    args.each do |action, verb|
      should "Require login for '#{action}' action" do
        if [:put, :delete].include?(verb) # put and delete require an id even if it is a bogus one
          send(verb, action, :id => 1)
        else
          send(verb, action)
        end
        assert_redirected_to(login_url)
      end
    end
  end

  # Ensure the user is in a given role for the given actions.  The test user will need to be logged in.
  # Parameters:
  #             role: The role required for the user
  #
  #             Pass the following as arguements
  #             :login_url => '/login'  -- url the user should be redirected to if they aren't logged in.  Defaults to '/login'
  #             :get => 'index'
  #             :post => 'create'
  #
  # Example:
  #            context "logged in not admin" do
  #              setup do
  #                @user = Factory(:user)
  #                activate_authlogic
  #                login_as @user
  #              end
  #              should_require_role('admin', :redirect_url => '/login', :index => :get)
  #            end
  def should_require_role(role, *args)
    args = Hash[*args]
    redirect_url = args.delete :redirect_url
    redirect_url ||= '/login'
    args.each do |action, verb|
      should "require role for '#{action}' action" do
        if [:put, :delete].include?(verb) # put and delete require an id even if it is a bogus one
          send(verb, action, :id => 1)
        else
          send(verb, action)
        end
        ensure_flash(/permission/i)
        assert_redirected_to(redirect_url)
      end
    end
  end
  
  #from: http://blog.internautdesign.com/2008/9/11/more-on-custom-shoulda-macros-scoping-of-instance-variables
  def should_not_allow action, object, url= "/login", msg=nil
    msg ||= "a #{object.class.to_s.downcase}" 
    should "not be able to #{action} #{msg}" do
      object = eval(object, self.send(:binding), __FILE__, __LINE__)
      get action, :id => object.id
      assert_redirected_to url
    end
  end

  def should_allow action, object, msg=nil
    msg ||= "a #{object.class.to_s.downcase}" 
    should "be able to #{action} #{msg}" do
      object = eval(object, self.send(:binding), __FILE__, __LINE__)
      get action, :id => object.id
      assert_response :success
    end
  end

  # make sure the response body matches the text exactly
  def should_render_text(text)
    should "render text #{text}" do
      assert_equal text, @response.body
    end
  end

  # look for the given text in the response body
  def should_render_partial_text(text)
    should "contain text #{text}" do
      assert @response.body.include?(text), "Response did not contain the text '#{text}'"
    end
  end
  
end

ActiveSupport::TestCase.extend(MuckControllerMacros)
Test::Unit::TestCase.extend(MuckControllerMacros)
ActionController::TestCase.extend(MuckControllerMacros)
