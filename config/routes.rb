Rails.application.routes.draw do
  match 'load_states_for_country/:id.:format' => 'muck/helper#load_states_for_country'
  match '/admin' => 'admin/muck/default#index', :as => :admin
end