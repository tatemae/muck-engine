require File.dirname(__FILE__) + '/../spec_helper'

describe Language do

  describe "locale_id" do
    before(:all) do
      @language = Factory(:unmodified_language, :locale => 'zz', :supported => true)
    end
    it "should find the language id for the current locale" do
      I18n.should_receive(:locale).and_return(:zz)
      Language.locale_id(true).should == @language.id
    end
  end

  describe "supported_locale?" do
    before(:all) do
      @supported_locale = 'zz'
      @not_supported_locale = 'aa'
      @supported_language = Factory(:unmodified_language, :locale => @supported_locale, :supported => true)
    end
    it "should indicate the locale is supported" do
      Language.supported_locale?(@supported_locale, true).should be_true
    end
    it "should indicate the locale is not supported" do
      Language.supported_locale?(@not_supported_locale, true).should_not be_true
    end
  end

end