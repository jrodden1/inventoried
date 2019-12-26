class ItemsController < ApplicationController
   before_action :is_logged_in? #checks to see if a user is logged in for all actions
   before_action :current_user
   before_action :set_item, only: [:show, :edit, :update, :destroy_item_from_all_locations]

   def index
      # This if/else logic below could be used if my routes were redone so that the nesting was actually location/2/items/3 - and just have items index have dual purpose
      # if params[:location_id]
      #    @location = Location.find_by_id(params[:location_id])
      #    @items = @location.items
      #    render :location_index
      # else
      
      #this makes the query sort order a bit more "sticky"
      @default = true if params[:order] != "desc"
      # checking to see if a query / search was made first to filter the results
      if params[:query].present?
         #using my scope method with chained on order method
         @items = Item.search(@user.id, params[:query]).order(name: params[:order].to_sym)

         if @items.empty?
            @no_results = "Your search returned no results"
            #so the user doesn't see anything, go ahead and show all the users items instead
            @items = @user.items
         end
      else 
         #otherwise, show all the user's items on the index page
         @items = @user.items
      end
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

   def destroy_item_from_all_locations
      #not implementing this in the MVP for my project
      #need to make sure that @item.destroy will destroy all the associated @location_item entries
      #there currently isn't a route that can hit this; when implementing, will need to add the route to routes.rb
      authorized?(resource_user_id: @location.user_id) do 
         #nothing right now.  need to ripple delete or request the user clunkily delete all the stock at all locations first. 
      end
   end

private
   def set_item
      @item = Item.find_by_id(params[:id])
   end
end

