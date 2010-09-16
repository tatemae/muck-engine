require File.dirname(__FILE__) + '/../../test_helper'

class Admin::Muck::DefaultControllerTest < ActionController::TestCase

  tests Admin::DefaultController

  context "logged in as admin" do
    
    setup do
      User.destroy_all
      activate_authlogic
      @admin = Factory(:user)
      @admin_role = Factory(:role, :rolename => 'administrator')
      @admin.roles << @admin_role
      login_as @admin
    end
    
    context "GET to admin index" do
      setup do
        get :index
      end
      should_respond_with :success
      should_render_template :index
    end
    
  end
  
  context "not logged in" do
    setup do
      get :index
    end
    should_respond_with :redirect
  end

end