require File.dirname(__FILE__) + '/../spec_helper'

describe BasicMailer do

  describe "deliver emails" do

    before(:all) do
      ActionMailer::Base.delivery_method = :test
      ActionMailer::Base.perform_deliveries = true
      ActionMailer::Base.deliveries = []
    end

    it "should send email" do
      body = 'test body'
      to = 'to@example.com'
      from = 'from@example.com'
      subject = 'test message'
      options = {:to => to, :from => from, :subject => subject, :body => body}
      email = BasicMailer.mail_from_params(options).deliver
      ActionMailer::Base.deliveries.should_not be_empty
      email.body.should include(body)
      email.to.should include(to)
      email.from.should include(from)
      email.subject.should == subject
    end
  end 
  
end