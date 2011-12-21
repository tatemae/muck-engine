module MuckEngine # :nodoc:
  module Models # :nodoc:
    module Matchers

      # 'newer_than' named scope which retrieves items newer than given date
      # requires that the class have a factory
      # Tests:
      #   scope :newer_than, lambda { |time| {:conditions => ["created_at < ?", time || 1.day.ago] } }
      # Examples:
      #   it { should scope_recent }
      def scope_newer_than
        TimeMatcher.new(:newer_than)
      end

      # 'scope_older_than' named scope which retrieves items older than the given date
      # requires that the class have a factory
      # Tests:
      #   scope :newer_than, lambda { |time| {:conditions => ["created_at < ?", time || 1.day.ago] } }
      # Examples:
      #   it { should scope_recent }
      def scope_older_than
        TimeMatcher.new(:older_than)
      end

      class TimeMatcher < MuckMatcherBase # :nodoc:

        def initialize(scope, field = :created_at)
          @scope = scope
          @field = field
        end

        def matches?(subject)
          @subject = subject
          @subject.class.delete_all
          old_item = Factory(factory_name, @field => 1.month.ago)
          new_item = Factory(factory_name, @field => 1.day.ago)
          items = @subject.class.send(@scope, 1.week.ago)
          if @scope == :newer_than
            items.include?(new_item) && !items.include?(old_item)
          elsif @scope == :older_than
            !items.include?(new_item) && items.include?(old_item)
          else
            raise "matcher not implemented for #{@scope}"
          end
        end

        def failure_message
          "Expected #{factory_name} to scope by #{@scope} on #{@field} and be successful. But the call failed"
        end

        def description
          "items scoped #{@scope}"
        end

      end

    end
  end
end
