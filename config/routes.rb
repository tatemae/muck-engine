Rails.application.routes.draw do
  
  # TODO make sure these routes are setup correctly
  
  match 'load_states_for_country(/:id(.:format))', :controller => 'muck/helper', :action => 'load_states_for_country'

  namespace :admin do
    match '/admin', :controller => 'admin/muck/default', :action => 'index'
  end
  
end


