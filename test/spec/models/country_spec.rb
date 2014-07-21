require File.dirname(__FILE__) + '/../spec_helper'

describe Country do

  before(:all) do
    @country = Factory(:country)
  end

  it { should have_many :states }
  it { should scope_by_name }

  describe "us" do
    before(:all) do
      Country.destroy_all
      @us_country = Factory(:country, :abbreviation => 'US')
      @other_country = Factory(:country)
    end
    it "should find countries with abbreviation 'US'" do
      Country.us.should == @us_country
    end
    it "should not find other countries" do
      Country.us.should_not == @other_country
    end
  end

  describe "uk_country?" do
    before(:all) do
      Country.destroy_all
      @eng_country = Factory(:country, :abbreviation => 'ENG')
      @ie_country = Factory(:country, :abbreviation => 'IE')
      @wal_country = Factory(:country, :abbreviation => 'WAL')
      @sct_country = Factory(:country, :abbreviation => 'SCT')
      @other_country = Factory(:country)
    end
    it "should determine if the country is a UK country" do
      Country.uk_country?(@eng_country.id, true).should be_true
      Country.uk_country?(@ie_country.id, true).should be_true
      Country.uk_country?(@wal_country.id, true).should be_true
      Country.uk_country?(@sct_country.id, true).should be_true
      Country.uk_country?(@other_country.id, true).should_not be_true
    end
    it "should be able to use country object or id" do
      Country.uk_country?(@eng_country, true).should be_true
      Country.uk_country?(@eng_country.id, true).should be_true
    end
  end

  describe "canada?" do
    before(:all) do
      Country.destroy_all
      @canada = Factory(:country, :abbreviation => 'CA')
      @other_country = Factory(:country)
    end
    it "should determine if the country is canada" do
      Country.canada?(@canada.id, true).should be_true
      !Country.canada?(@other_country.id, true).should_not be_true
    end
  end

  describe "build_state_prompts" do
    before(:all) do
      Country.destroy_all
      @us_country = Factory(:country, :abbreviation => 'US')
      @eng_country = Factory(:country, :abbreviation => 'ENG')
      @canada = Factory(:country, :abbreviation => 'CA')
    end
    it "should return county for UK" do
      label, prompt = Country.build_state_prompts(@eng_country, false, true)
      prompt.should include('county')
      label.should include('County')
    end
    it "should return province for canada" do
      label, prompt = Country.build_state_prompts(@canada, false, true)
      prompt.should include('province')
      label.should include('Province')
    end
    it "should return state for other" do
      label, prompt = Country.build_state_prompts(@us_country, false, true)
      prompt.should include('state')
      label.should include('State')
    end
  end

end