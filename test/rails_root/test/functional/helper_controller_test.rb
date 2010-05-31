require File.dirname(__FILE__) + '/../test_helper'

class HelperControllerTest < ActionController::TestCase

  tests Muck::HelperController

  context "load_states_for_country" do

    setup do
      @country = Factory(:country)
      @state = Factory(:state, :country => @country)
      get :load_states_for_country, :id => @country.to_param, :format => 'json'
    end
    should_respond_with :success
    should "include state in resulting json" do
      assert @response.body.include?(@state.name)
    end
  end

end