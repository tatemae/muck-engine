module MuckEngine # :nodoc:
  module Models # :nodoc:
    module Matchers

      # Ensures that the model sanitizes the given attributes
      def sanitize(attribute)
        SanitizeMatcher.new(attribute)
      end
      
      class SanitizeMatcher < MuckMatcherBase # :nodoc:
        
        def initialize(attribute)
          @attribute = attribute
        end
        
        def matches?(subject)
          @subject = subject
          sanitizes?
        end
        
        def failure_message
          "#{factory_name} does not correctly sanitize the attribute #{@attribute}"
        end
        
        def description
          "sanitizes attribute"
        end
        
        private
        
          def sanitizes?
            bad_scripts = [
              %|';alert(String.fromCharCode(88,83,83))//\';alert(String.fromCharCode(88,83,83))//";alert(String.fromCharCode(88,83,83))//\";alert(String.fromCharCode(88,83,83))//--></SCRIPT>">'><SCRIPT>alert(String.fromCharCode(88,83,83))</SCRIPT>|,
              %|'';!--"<XSS>=&{()}|,
              %|<SCRIPT SRC=http://ha.ckers.org/xss.js></SCRIPT>|,
              %|<IMG SRC="javascript:alert('XSS');">|,
              %|<IMG SRC=javascript:alert('XSS')>|,
              %|<IMG SRC=JaVaScRiPt:alert('XSS')>|,
              %|<IMG SRC=JaVaScRiPt:alert('XSS')>|,
              %|<IMG SRC=`javascript:alert("RSnake says, 'XSS'")`>|,
              %|<IMG """><SCRIPT>alert("XSS")</SCRIPT>">|,
              %|<IMG SRC=javascript:alert(String.fromCharCode(88,83,83))>|,
              %|<A HREF="h
              tt	p://6&#9;6.000146.0x7.147/">XSS</A>|,
              %|<script>alert('message');</script>| ]
            bad_scripts.each do |bad_value|
              @subject.send("#{@attribute}=", bad_value)
              @subject.save
              clean_value = @subject.send(@attribute)
              return false if clean_value.include?(bad_value)
            end
            true            
          end
          
      end

    end
  end
end