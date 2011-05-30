module MuckEngine # :nodoc:
  module Models # :nodoc:
    module Matchers
      
      # 'is_public' named scope which retrieves items that are marked public
      # requires that the class have a factory
      # Tests:
      #   scope :newer_than, lambda { |time| {:conditions => ["created_at < ?", time || 1.day.ago] } }
      # Examples:
      #   it { should scope_is_public }
      def scope_is_public
        IsPublicMatcher.new(:is_public)
      end
            
      class IsPublicMatcher < MuckMatcherBase # :nodoc:

        def initialize(scope, field = :is_public)
          @scope = scope
          @field = field
        end
        
        def matches?(subject)
          @subject = subject
          @subject.class.delete_all
          public_item = Factory(factory_name, @field => true)
          not_public_item = Factory(factory_name, @field => false)
          @subject.class.send(@scope).include?(public_item) &&
            !@subject.class.send(@scope).include?(not_public_item)
        end
        
        def failure_message
          "Expected #{factory_name} to scope by #{@scope} on #{@field} and only find public items. But the call failed"
        end
        
        def description
          "public items"
        end
          
      end

    end
  end
end