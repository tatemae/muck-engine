module MuckEngine
  module Models
    module State
      extend ActiveSupport::Concern

      included do
        belongs_to :country
        scope :by_name, order("name ASC")
      end
      
    end
  end
end
