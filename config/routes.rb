Rails.application.routes.draw do
  root 'static#home'
  
  delete '/logout', to: "sessions#logout"
  get '/signup', to: "users#signup"
  get '/login', to: "sessions#login"
  post '/login', to: "sessions#create"
  
  
  resources :users, except: [:new, :delete]
  resources :locations do
    resources :items
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end