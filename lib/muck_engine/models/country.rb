#include MuckEngine::Models::MuckCountry
module MuckEngine
  module Models
    module MuckCountry
      extend ActiveSupport::Concern
    
      included do
        has_many :states
        scope :by_name, order("name ASC")
      end
      
      module ClassMethods
        def us
          self.find_by_abbreviation('US')
        end

        def uk_country?(country, refresh_ids = false)
          if refresh_ids || !defined?(@@uk_country_ids)
            uk_countries = self.find(:all, :conditions => ["abbreviation in (?)", ['ENG', 'IE', 'WAL', 'SCT']])
            @@uk_country_ids = uk_countries.map(&:id)
          end
          @@uk_country_ids.include?(get_country_id(country))
        end

        def canada?(country, refresh_ids = false)
          @@canada_id = nil if refresh_ids
          @@canada_id ||= self.find_by_abbreviation('CA').id
          @@canada_id == get_country_id(country)
        end
        
        # Note that the strings from here are also hard coded into application.js
        def build_state_prompts(country_id, any = false, refresh_ids = false)
          if uk_country?(country_id, refresh_ids)
            label = 'Choose County'
            if any
              prompt = 'Any County (or unknown)'
            else
              prompt = 'Please select a county'
            end
          elsif canada?(country_id, refresh_ids)
            label = 'Choose Province'
            if any
              prompt = 'Any Province (or unknown)'
            else
              prompt = 'Please select a province'
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
        
        private
        
          def get_country_id(country)
            if country.is_a?(self)
              country.id
            else
              country.to_i
            end
          end
          
      end
      
    end
  end
end
