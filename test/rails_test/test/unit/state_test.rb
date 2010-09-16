require File.dirname(__FILE__) + '/../test_helper'

class StateTest < ActiveSupport::TestCase

  context "a state instance" do
    
    setup do
      @state = Factory(:state)
    end
    
    subject { @state }
    
    should_belong_to :country
    should_scope_by_name
    
  end
  
end