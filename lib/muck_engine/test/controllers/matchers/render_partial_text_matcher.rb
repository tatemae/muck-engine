module MuckEngine # :nodoc:
  module Controllers # :nodoc:
    module Matchers
   
      # Ensure a that the response contains the specified text
      #
      # Example:
      #           it { should render_partial_text 'foobar' }
      def render_partial_text(text)
        PartialTextMatcher.new(text)
      end
      
      class PartialTextMatcher
        
        def initialize(text)
          @text = text
        end
        
        def matches?(controller)
          @controller = controller
          @controller.response.body.include?(@text)
        end
        
        def failure_message
          "#{@controller.response.body} does not contain '#{@text}'"
        end

        def description
          "response contains #{@text}"
        end
        
      end
      
    end
  end
end