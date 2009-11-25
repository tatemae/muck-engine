class ActionController::Routing::RouteSet
  def load_routes_with_muck_engine!
    muck_engine_routes = File.join(File.dirname(__FILE__), *%w[.. .. config muck_engine_routes.rb])
    add_configuration_file(muck_engine_routes) unless configuration_files.include? muck_engine_routes
    load_routes_without_muck_engine!
  end
  alias_method_chain :load_routes!, :muck_engine
end