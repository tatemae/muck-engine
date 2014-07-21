require File.dirname(__FILE__) + '/../spec_helper'

describe State do

  before(:all) do
    @state = Factory(:state)
  end

  it { should belong_to :country }
  it { should scope_by_name }

end
