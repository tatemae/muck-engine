require File.dirname(__FILE__) + '/../spec_helper'

describe MuckEngineHelper do
  
  describe "http_protocol" do
    
    describe "secure request" do
      before(:all) do
        helper.request.stub!(:ssl?).and_return(true)
      end
      it "returns https when ssl is true" do
        helper.http_protocol(true).should == 'https://'
      end
      it "returns https when request is ssl" do
        helper.http_protocol.should == 'https://'
      end
    end
    
    describe "normal request" do
      before(:all) do
        helper.request.stub!(:ssl?).and_return(false)
      end
      it "returns http when ssl is false" do
        helper.http_protocol(false).should == 'http://'
      end
      it "returns http when request is not ssl" do
        helper.http_protocol.should == 'http://'
      end
    end
    
  end
  
end


# 
# raw_post = mock('raw_post')
# raw_post.should_receive(:to_s).and_return('this string')
# request.stub!(:raw_post).and_return(:raw_pos

# request.env['HTTP_USER_AGENT'] = 'mozilla blah blah' 
# get :new
