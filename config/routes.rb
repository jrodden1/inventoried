Rails.application.routes.draw do
  root 'static#home'
  
  get '/signup', to: "users#signup"
  get '/login', to: "sessions#login"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#logout"
  
  resources :users, except: [:new, :delete]
  resources :locations do
    resources :items
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
