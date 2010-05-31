require File.dirname(__FILE__) + '/../test_helper'

class LangaugeTest < ActiveSupport::TestCase

  context "a language instance" do
    
    context "locale_id" do
      setup do
        @language = Factory(:unmodified_language, :locale => 'zz', :supported => true)
        I18n.stubs(:locale).returns(:zz)
      end
      should "find the language id for the current locale" do
        assert_equal @language.id, Language.locale_id(true)
      end
    end
    
    context "supported_locale?" do
      setup do
        @supported_locale = 'zz'
        @not_supported_locale = 'aa'
        @supported_language = Factory(:unmodified_language, :locale => @supported_locale, :supported => true)
      end
      should "indicate the locale is supported" do
        assert Language.supported_locale?(@supported_locale, true)
      end
      should "indicate the locale is not supported" do
        assert !Language.supported_locale?(@not_supported_locale, true)
      end
    end
    
  end
  
end