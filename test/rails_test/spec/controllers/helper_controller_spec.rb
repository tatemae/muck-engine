require File.dirname(__FILE__) + '/../spec_helper'

describe Muck::HelperController do

  describe "load_states_for_country" do
    before(:all) do
      @country = Factory(:country)
      @state = Factory(:state, :country => @country)
      @canada = Factory(:country, :abbreviation => 'CA')
      @us = Factory(:country, :abbreviation => 'US')
      @other_country = Factory(:country)
    end
    it "should load" do
      get_load_states_for_country
      should respond_with :success
    end
    it "should include state in resulting json" do
      get_load_states_for_country
      @response.body.should include(@state.name)
    end
  end
  
  def get_load_states_for_country
    get :load_states_for_country, :id => @country.to_param, :format => 'json'
  end
  
end
