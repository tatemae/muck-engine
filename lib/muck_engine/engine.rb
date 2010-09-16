require 'muck_engine'
require 'rails'

module MuckEngine
  class Engine < ::Rails::Engine
    
    def muck_name
      'muck-engine'
    end

    initializer 'muck_engine.mime_types' do |app|
      Mime::Type.register "application/rdf+xml", :rdf
      Mime::Type.register "text/xml", :opml
      Mime::Type.register "text/javascript", :pjs
      Mime::Type.register_alias "text/html", :iphone
    end
          
    initializer 'muck_engine.controllers' do |app|
      ActiveSupport.on_load(:action_controller) do
        include MuckEngine::Application
        include MuckEngine::FlashErrors
      end
    end
    
    initializer 'muck_engine.helpers' do |app|
      ActiveSupport.on_load(:action_view) do
        include MuckEngineHelper
        include MuckAdminHelper
      end
    end
    
    initializer 'muck_engine.models' do |app|
      ActiveSupport.on_load(:active_record) do
        include MuckEngine::General
        # include MuckEngine::Models::Language
        # include MuckEngine::Models::Country
        # include MuckEngine::Models::State
      end
    end
    
    initializer 'muck_engine.mailer' do |app|
      ActiveSupport.on_load(:action_mailer) do
        include MuckEngine::Mailers::General
      end
    end
   
    initializer 'muck_engine.i18n' do |app|
      ActiveSupport.on_load(:i18n) do
        I18n.load_path += Dir[ File.join(File.dirname(__FILE__), '..', '..', 'rails_i18n', '*.{rb,yml}') ]
      end
    end
    
  end
end
