module ActiveRecord
  module Acts #:nodoc:
    module MuckState #:nodoc:

      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def acts_as_muck_state
          belongs_to :country
          named_scope :by_name, :order => "name ASC"
        
          include ActiveRecord::Acts::MuckState::InstanceMethods
          extend ActiveRecord::Acts::MuckState::SingletonMethods
        
        end
      end
      
      # class methods
      module SingletonMethods        
      end
      
      # All the methods available to a record that has had <tt>acts_as_muck_invite</tt> specified.
      module InstanceMethods
      end
      
    end
  end
end
