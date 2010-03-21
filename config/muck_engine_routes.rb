ActionController::Routing::Routes.draw do |map|
  
  map.connect 'load_states_for_country/:id.:format', :controller => 'muck/helper', :action => 'load_states_for_country'
  
  # admin
  map.admin '/admin', :controller => 'admin/muck/default', :action => 'index'
  
end
