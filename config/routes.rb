Rails.application.routes.draw do
  resources :users
  get 'users/signup'
  get 'users/edit'
  get 'users/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
