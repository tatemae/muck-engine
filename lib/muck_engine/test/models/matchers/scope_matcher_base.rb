module MuckEngine # :nodoc:
  module Models # :nodoc:
    module Matchers
      
      class ScopeMatcherBase # :nodoc:

        private
          
          def factory_name
            @subject.class.name.underscore.to_sym
          end
      
      end
      
    end
  end
end