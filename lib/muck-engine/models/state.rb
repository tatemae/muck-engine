# include MuckEngine::Models::MuckState
module MuckEngine
  module Models
    module MuckState
      extend ActiveSupport::Concern

      included do
        belongs_to :country
        scope :by_name, order("name ASC")
      end
      
    end
  end
end
