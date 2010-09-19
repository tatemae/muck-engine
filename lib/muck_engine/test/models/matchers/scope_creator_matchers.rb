module MuckEngine # :nodoc:
  module Models # :nodoc:
    module Matchers

      # Ensures that the model can scope by 'source'
      # requires that the class have a factory and that a user factory exist
      # Tests:
      #   scope :created_by, lambda { |item_object| {:conditions => ["items.source_id = ? AND items.source_type = ?", item_object.id, item_object.class.to_s] } }  
      # Examples:
      #   it { should scope_created_by }
      def scope_source
        CreatedByMatcher.new(:source, :source)
      end
            
      # Ensures that the model can scope by created_by
      # requires that the class have a factory and that a user factory exist
      # Tests:
      #   scope :created_by, lambda { |user| where(['user_id = ?', user.id]) } }
      # Examples:
      #   it { should scope_created_by }
      def scope_created_by
        CreatedByMatcher.new(:created_by, :user)
      end

      # Ensures that the model can scope by created_by
      # requires that the class have a factory and that a user factory exist
      # Tests:
      #   scope :by_creator, lambda { |creator| where(['creator_id = ?', creator.id]) } }
      # Examples:
      #   it { should scope_by_creator }
      def scope_by_creator
        CreatedByMatcher.new(:by_creator, :creator)
      end
      
      class CreatedByMatcher < ScopeMatcherBase # :nodoc:
        
        def initialize(scope, field)
          @scope = scope
          @field = field
        end
        
        def matches?(subject)
          @subject = subject
          @subject.class.delete_all
          @user = Factory(:user)
          @user1 = Factory(:user)
          @item = Factory(factory_name, @field => @user)
          @item1 = Factory(factory_name, @field => @user1)
          items = @subject.class.send(@scope, @user)
          items.include?(@item) && !items.include?(@item1)
        end
        
        def failure_message
          "Expected #{factory_name} to have scope created_by and to be able to successfully find #{@subject}'s creator"
        end
        
        def description
          "scope created_by"
        end
          
      end

    end
  end
end