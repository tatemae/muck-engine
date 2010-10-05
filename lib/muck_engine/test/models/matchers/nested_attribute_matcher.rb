module MuckEngine # :nodoc:
  module Models # :nodoc:
    module Matchers

      # Ensures that the model can accept nested attributes for the given model
      def accept_nested_attributes_for(nested_model)
        NestedAttributeMatcher.new(nested_model)
      end
      
      class NestedAttributeMatcher < MuckMatcherBase # :nodoc:
        
        def initialize(nested_model)
          @nested_model = nested_model
        end
        
        def matches?(subject)
          @subject = subject
          @subject.instance_methods.include?("#{@nested_model}_attributes=")
        end
        
        def failure_message
          "#{factory_name} does not accept nested attributes for #{@nested_model}"
        end
        
        def description
          "accepts nested attributes for"
        end
          
      end

    end
  end
end