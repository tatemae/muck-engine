module MuckEngine # :nodoc:
  module Models # :nodoc:
    module Matchers

      # 'active' named scope which indicates whether an item is active or not
      # requires that the class have a factory
      # Tests:
      #   scope :newer_than, lambda { |time| {:conditions => ["created_at < ?", time || 1.day.ago] } }
      # Examples:
      #   it { should scope_active }
      def scope_active
        ActiveMatcher.new(:active)
      end

      class ActiveMatcher < MuckMatcherBase # :nodoc:

        def initialize(scope, field = :active)
          @scope = scope
          @field = field
        end

        def matches?(subject)
          @subject = subject
          @subject.class.delete_all
          active_item = Factory(factory_name, @field => true)
          not_active_item = Factory(factory_name, @field => false)
          @subject.class.send(@scope).include?(active_item) &&
            !@subject.class.send(@scope).include?(not_active_item)
        end

        def failure_message
          "Expected #{factory_name} to scope by #{@scope} on #{@field} and only find active items. But the call failed"
        end

        def description
          "active items"
        end

      end

    end
  end
end