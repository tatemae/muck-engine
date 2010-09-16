RailsTest::Application.routes.draw do
  root :to => "default#index"
  match ':controller(/:action(/:id(.:format)))'
end
