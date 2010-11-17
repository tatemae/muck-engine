require File.dirname(__FILE__) + '/../spec_helper'

describe MuckAdminHelper do
  
  describe "header_nav_item_image" do
    it "will output a background style with an image" do
      header_nav_item = mock(:header_nav_item)
      header_nav_item.stub!(:image).and_return('something.gif')
      helper.header_nav_item_image(header_nav_item).should include("background-image:url('something.gif');")
    end
  end
  
  describe "hide_admin_messages" do
    it "will hide admin messages" do
      helper.hide_admin_messages.should include(".hide();")
    end
  end
  
end