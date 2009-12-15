ActiveSupport::Dependencies.load_once_paths << lib_path # disable reloading of this plugin

if config.respond_to?(:gems)
  config.gem "validation_reflection"
else
  begin
    require 'validation_reflection'
  rescue LoadError
    begin
      gem 'validation_reflection'
    rescue Gem::LoadError
      puts "Please install the validation_reflection gem"
    end
  end
end

require 'muck_engine'
require 'muck_engine/initialize_routes'
require 'muck_engine/populate'