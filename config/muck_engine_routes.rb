ActionController::Routing::Routes.draw do |map|
  map.resources :helper, :controller => 'muck/helper', :collection => { :load_states_for_country => :get }
end
