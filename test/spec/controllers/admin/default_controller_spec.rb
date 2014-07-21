require File.dirname(__FILE__) + '/../../spec_helper'

describe Admin::Muck::DefaultController do

  render_views

  describe "logged in as admin" do

    before(:each) do
      User.destroy_all
      activate_authlogic
      @admin = Factory(:user)
      @admin_role = Factory(:role, :rolename => 'administrator')
      @admin.roles << @admin_role
      login_as @admin
    end

    describe "GET to admin index" do
      before(:each) do
        get :index
      end
      it { should respond_with :success }
      it { should render_template :index }
    end

  end

  describe "not logged in" do
    before(:each) do
      get :index
    end
    it { should respond_with :redirect }
  end

end




