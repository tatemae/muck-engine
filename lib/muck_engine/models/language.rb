module MuckEngine
  module Models
    module Language
      extend ActiveSupport::Concern
    
      module ClassMethods        
        def locale_id(refresh_ids = false)
          cache_locale_ids(refresh_ids)
          @@locale_ids[I18n.locale]
        end

        def supported_locale?(locale, refresh_ids = false)
          cache_locale_ids(refresh_ids)
          @@locale_ids[locale.to_sym] != nil
        end

        private

          def cache_locale_ids(refresh_ids = false)
            if refresh_ids || !defined?(@@locale_ids)
              languages = self.find(:all, :select => 'id, locale', :conditions => ['languages.supported = ?', true])
              @@locale_ids = Hash[*languages.collect {|v|[v.locale[0..1].to_sym, v.id]}.flatten]
            end
          end
          
      end
      
    end
  end
end





