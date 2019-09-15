Rails.application.routes.draw do
  root 'static#home'
  
  delete '/logout', to: "sessions#logout"
  get '/signup', to: "users#signup"
  get '/login', to: "sessions#login"
  post '/login', to: "sessions#create"
  get '/auth/facebook/callback' => 'sessions#create'
  delete '/locations/:location_id/location_items/:id', to: "location_items#destroy_location_item_only", as: "delete_location_item"


  resources :users, only: [:create]
  resources :locations do
    resources :location_items, except: [:delete], as: :items
  end
  resources :items, only: [:index, :show]
  #below will be my custom delete route -- if needed to completely delete an item from all locations.  
  #delete '/locations/:location_id/items/:id', to: "location_items#destroy_location_item_only", as: "delete_location_item"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end