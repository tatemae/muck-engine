module ActiveRecord
  module Acts #:nodoc:
    module MuckLanguage #:nodoc:

      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def acts_as_muck_language
          include ActiveRecord::Acts::MuckLanguage::InstanceMethods
          extend ActiveRecord::Acts::MuckLanguage::SingletonMethods
        end
      end
      
      # class methods
      module SingletonMethods        
        def locale_id(refresh_ids = false)
          cache_locale_ids
          @@locale_ids[I18n.locale]
        end

        def supported_locale?(locale, refresh_ids = false)
          cache_locale_ids
          @@locale_ids[locale.to_sym] != nil
        end

        private

          def cache_locale_ids(refresh_ids = false)
            if refresh_ids || !defined?(@@locale_ids)
              languages = Language.find(:all, :select => 'id, locale', :conditions => ['languages.supported = ?', true])
              @@locale_ids = Hash[*languages.collect {|v|[v.locale[0..1].to_sym, v.id]}.flatten]
            end
          end
          
      end
      
      # All the methods available to a record that has had <tt>acts_as_muck_invite</tt> specified.
      module InstanceMethods
      end
      
    end
  end
end





