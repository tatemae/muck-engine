# == Schema Information
#
# Table name: countries
#
#  id           :integer         not null, primary key
#  name         :string(128)     default(""), not null
#  abbreviation :string(3)       default(""), not null
#  sort         :integer         default(1000), not null
#

class Country < ActiveRecord::Base
  
  has_many :states
  
  named_scope :by_name, :order => "name ASC"
  
  def self.us
    self.find_by_abbreviation('US')
  end
  
  def self.uk_country?(country_id)
    unless defined?(@@uk_country_ids)
      uk_countries = Country.find(:all, :conditions => ["abbreviation in (?)", ['ENG', 'IE', 'WAL', 'SCT']])
      @@uk_country_ids = uk_countries.map(&:id)
    end
    @@uk_country_ids.include?(country_id.to_i)
  end
  
  def self.canada?(country_id)
    @@canada_id ||= Country.find_by_abbreviation('CA').id
    @@canada_id == country_id.to_i
  end
  
  # Note that the strings from here are also hard coded into application.js
  def self.build_state_prompts(country_id, any = false)
    if uk_country?(country_id)
      label = 'Choose County'
      if any
        prompt = 'Any County (or unknown)'
      else
        prompt = 'Please select a county'
      end
    elsif canada?(country_id)
      label = 'Choose Province'
      if any
        prompt = 'Any Province (or unknown)'
      else
        prompt = 'Please select a Province'
      end
    else
      label = 'Choose State'
      if any
        prompt = 'Any State (or unknown)'
      else
        prompt = 'Please select a state'
      end
    end
    [label, prompt]
  end
  
end
