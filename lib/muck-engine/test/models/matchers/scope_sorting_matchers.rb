module MuckEngine # :nodoc:
  module Models # :nodoc:
    module Matchers

      # Ensures that the model can sort by_title
      # requires that the class have a factory
      # Tests:
      #   scope :by_title, order("title ASC")
      # Examples:
      #   it { should scope_by_title }
      def scope_by_title
        SortingMatcher.new(:by_title, :title)
      end

      # Test for 'by_name' named scope which orders by name
      # requires that the class have a shoulda factory
      # Tests:
      #   scope :by_name, order("name ASC")
      # Examples:
      #   it { should scope_by_name }
      def scope_by_name
        SortingMatcher.new(:by_name, :name)
      end

      # For 'by_latest named scope which orders by updated at:
      # Tests:
      #   scope :by_latest, order("updated_at DESC")
      # Examples:
      #   it { should scope_by_latest }
      def scope_by_latest
        SortingMatcher.new(:by_latest, :updated_at)
      end

      # Test for 'by_newest' named scope which orders by 'created_at DESC'
      # requires that the class have a shoulda factory
      # Tests:
      #   scope :by_newest, order("created_at DESC")
      # Examples:
      #   it { should scope_by_newest }
      def scope_by_newest
        SortingMatcher.new(:by_newest, :created_at)
      end

      # Test for 'by_oldest' named scope which orders by 'created_at ASC'
      # requires that the class have a shoulda factory
      # Tests:
      #   scope :oldest, order("created_at ASC")
      # Examples:
      #   it { should scope_oldest }
      def scope_by_oldest
        SortingMatcher.new(:by_oldest, :created_at)
      end

      class SortingMatcher < MuckMatcherBase # :nodoc:

        def initialize(scope, field)
          @scope = scope
          @field = field
        end

        def matches?(subject)
          @subject = subject
          @subject.class.delete_all
          if @scope == :by_newest
            first = Factory(factory_name, :created_at => 1.hour.ago)
            second = Factory(factory_name, :created_at => 1.day.ago)
            first == @subject.class.send(@scope)[0] && second == @subject.class.send(@scope)[1]
          elsif @scope == :by_oldest
            first = Factory(factory_name, :created_at => 1.day.ago)
            second = Factory(factory_name, :created_at => 1.hour.ago)
            first == @subject.class.send(@scope)[0] && second == @subject.class.send(@scope)[1]
          elsif @scope == :by_latest
            first = Factory(factory_name, :updated_at => 1.hour.ago)
            second = Factory(factory_name, :updated_at => 1.day.ago)
            first == @subject.class.send(@scope)[0] && second == @subject.class.send(@scope)[1]
          else
            first = Factory(factory_name, @field => 'a')
            second = Factory(factory_name, @field => 'b')
            first == @subject.class.send(@scope)[0] && second == @subject.class.send(@scope)[1]
          end
        end

        def failure_message
          "Expected #{factory_name} to scope #{@scope} on #{@field}"
        end

        def description
          "sorting"
        end

      end

    end
  end
end
