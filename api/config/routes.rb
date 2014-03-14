Api::Application.routes.draw do
  resources :experiences, :only => [:index, :create, :show]
end
