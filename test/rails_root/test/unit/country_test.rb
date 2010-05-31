require File.dirname(__FILE__) + '/../test_helper'

class CountryTest < ActiveSupport::TestCase

  context "a country instance" do
    
    setup do
      @country = Factory(:country)
    end
    
    subject { @country }
    should_have_many :states
    should_scope_by_name
    
    context "us" do
      setup do
        Country.destroy_all
        @us_country = Factory(:country, :abbreviation => 'US')
        @other_country = Factory(:country)
      end
      should "find countries with abbreviation 'US'" do
        assert_equal @us_country, Country.us
      end
      should "not find other countries" do
        assert_not_equal @other_country, Country.us
      end
    end
    
    context "uk_country?" do
      setup do
        Country.destroy_all
        @eng_country = Factory(:country, :abbreviation => 'ENG')
        @ie_country = Factory(:country, :abbreviation => 'IE')
        @wal_country = Factory(:country, :abbreviation => 'WAL')
        @sct_country = Factory(:country, :abbreviation => 'SCT')
        @other_country = Factory(:country)
      end
      should "determine if the country is a UK country" do
        assert Country.uk_country?(@eng_country.id, true)
        assert Country.uk_country?(@ie_country.id, true)
        assert Country.uk_country?(@wal_country.id, true)
        assert Country.uk_country?(@sct_country.id, true)
        assert !Country.uk_country?(@other_country.id, true)
      end
      should "be able to use country object or id" do
        assert Country.uk_country?(@eng_country, true)
        assert Country.uk_country?(@eng_country.id, true)
      end
    end
    
    context "canada?" do
      setup do
        Country.destroy_all
        @canada = Factory(:country, :abbreviation => 'CA')
        @other_country = Factory(:country)
      end
      should "determine if the country is canada" do
        assert Country.canada?(@canada.id, true)
        assert !Country.canada?(@other_country.id, true)
      end
    end
    
    context "build_state_prompts" do
      setup do
        Country.destroy_all
        @us_country = Factory(:country, :abbreviation => 'US')
        @eng_country = Factory(:country, :abbreviation => 'ENG')
        @canada = Factory(:country, :abbreviation => 'CA')
      end
      should "return county for UK" do
        label, prompt = Country.build_state_prompts(@eng_country)
        assert prompt.include?('county')
      end
      should "return province for canada" do
        label, prompt = Country.build_state_prompts(@canada)
        assert prompt.include?('province')
      end
      should "return state for other" do
        label, prompt = Country.build_state_prompts(@us_country)
        assert prompt.include?('state')
      end
    end
    
  end
  
end