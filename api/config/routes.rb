Api::Application.routes.draw do
  resources :experiences, :except => [:new, :update]
end
