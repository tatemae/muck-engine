module MuckEngine # :nodoc:
  module Models # :nodoc:
    module Matchers
      
      # Ensures that the model can sort by 'sorted'
      # requires that the class have a factory
      # Tests:
      #   scope :sorted, order("sort ASC")
      # Examples:
      #   it { should scope_sorted }
      def scope_sorted
        OrdinalMatcher.new(:sorted, :sort)
      end

      #   it { should scope_sorted_id }
      def scope_sorted_id
        OrdinalMatcher.new(:sorted_id, :sort)
      end

      class OrdinalMatcher < MuckMatcherBase # :nodoc:

        def initialize(scope, field)
          @scope = scope
          @field = field
        end
        
        def matches?(subject)
          @subject = subject
          @subject.class.delete_all
          @first = Factory(factory_name, @field => 1)
          @second = Factory(factory_name, @field => 2)
          @first == @subject.class.send(@scope)[0] && @second == @subject.class.send(@scope)[1]
        end
        
        def failure_message
          "Expected #{factory_name} to have scope #{@scope} and order by #{@field}"
        end
        
        def description
          "sort by ordinal"
        end
          
      end

    end
  end
end
