class ItemsController < ApplicationController
   before_action :is_logged_in? #checks to see if a user is logged in for all actions
   before_action :current_user
   before_action :set_item, only: [:show, :edit, :update, :destroy_item_from_all_locations]

   def index
      #checking to see if a query / search was made first to filter the results
      if params[:query].present?
         #using my scope method with chained on order method
         @items = Item.search(@user.id, params[:query]).order(name: params[:order].to_sym)
         
         if @items.empty?
            @no_results = "Your search returned no results"
            @items = @user.items
         end
      else 
         #otherwise, show all the user's items on the index page
         @items = @user.items
      end
   end
   
   def new
      #allow me to create a new item and assign it to an existing location
      #otherwise, prompt the user to create a location first
      #not implementing this in the MVP for my project
   end
   
   def create
      #not implementing this in the MVP for my project
   end
   
   def show
      authorized?(resource_user_id: @item.user.id, redirect_if_logged_in_path: items_path) do
      #show the item itself and all the locations it is in (with associated quantities) Display total amount 
      #i already have @item at this point because of before_action
         @locations = @item.locations
      end
   end
   
   def edit 
      #not implementing this in the MVP for my project 
   end
   
   def update
      #not implementing this in the MVP for my project
      #update only the name; later on could add the ability to manage inventory / transfer inventory between locations
   end  
#Add this funcationality if later - REFACTOR -- probably place it under a route of just localhost:3000/items - which will show all the items owned and which locations they are in.  
   def destroy_item_from_all_locations
      #not implementing this in the MVP for my project
      #need to make sure that @item.destroy will destroy all the associated @location_item entries
      authorized?(resource_user_id: @location.user_id) do 
         #nothing right now.  need to ripple delete or request the user clunkily delete all the stock at all locations first. 
      end
      # DO NOT FORGET TO UPDATE routes.rb to reflect these new actions
   end

private
   def set_item
      @item = Item.find_by_id(params[:id])
   end
end

