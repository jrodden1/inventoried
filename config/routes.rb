Rails.application.routes.draw do
  get 'sessions/login'
  get 'sessions/logout'
  resources :items
  resources :locations
  resources :users
  get 'users/signup'
  get 'users/edit'
  get 'users/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
