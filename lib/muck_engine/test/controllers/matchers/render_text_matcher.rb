
module MuckEngine # :nodoc:
  module Controllers # :nodoc:
    module Matchers
   
      # Ensure a that the response matches the specified text
      #
      # Example:
      #           it { should render_partial_text 'foobar' }
      def render_text(text)
        TextMatcher.new(text)
      end
      
      class TextMatcher
        
        def initialize(text)
          @text = text
        end
        
        def matches?(controller)
          @controller = controller
          @controller.response.body == @text
        end
        
        def failure_message
          "Expected the response to be '#{@text}' but it was #{@controller.response.body}"
        end

        def description
          "response is #{@text}"
        end
        
      end
      
    end
  end
end