module MuckEngine # :nodoc:
  module Models # :nodoc:
    module Matchers

      # Ensures that the model can sort by_title
      # requires that the class have a factory
      #
      # Tests scope:
      #   scope :by_title, :order => "title ASC"
      #
      # Examples:
      #   it { should scope_by_title }
      #
      def scope_by_title
        SortingMatcher.new(:by_title, :title)
      end


      def scope_by_name
        SortingMatcher.new(:by_name, :name)
      end
      
      class SortingMatcher # :nodoc:

        def initialize(scope, field)
          @scope = scope
          @field = field
        end
        
        def matches?(subject)
          @subject = subject
          @subject.class.delete_all
          @first = Factory(factory_name, @field => 'a')
          @second = Factory(factory_name, @field => 'b')
          @first == @subject.class.send(@scope)[0] && @second == @subject.class.send(@scope)[1]
        end
        
        def failure_message
          "Expected #{factory_name} to scope by #{@scope} on #{@field}"
        end
        
        def description
          "sort by title"
        end

        private
        
          def factory_name
            @subject.class.name.underscore.to_sym
          end
          
      end

    end
  end
end
