class LocationItemsController < ApplicationController
   before_action :is_logged_in? #checks to see if a user is logged in for all actions
   before_action :current_user #sets @user for all actions
   before_action :set_location_by_location_id
   before_action :set_location_item, only: [:show, :edit, :update, :destroy_location_item_only]
   before_action :set_item, only: [:show, :edit, :update, :destroy_location_item_only]
   
   def index
      @location_items = @location.location_items
   end
   
   def new
      @item = @location.items.build
      @location_item = @location.location_items.build
      #this next bit of logic will only retrieve the items that the user owns that are currently not in this location. This should most likely be refactored to increase efficiency so I'm not hitting the DB so much.
      #first grab all the ids of the items in this location
      location_item_ids = @location.items.map {|item| item.id}
      #then reject any of the user owned items that are in this location already so I can't add an existing item as a dupe
      @user_items = @user.items.reject do |uitem|
         location_item_ids.find {|item_id| uitem.id == item_id}
      end
   end
   
   def create
      #This create method could probably be cleaned up into some helper methods - looks kind of huuuuugee, but is dealing with controller-esque kind of things so leaving it for now.  
      authorized?(resource_user_id: @location.user_id) do 
         #check to see if I'm creating a new location item from an existing item that the user owns (just not at this location)
         if params[:existing_item].present?
            #if so, then find the existing item id that the user picked
            @item = Item.find_by_id(params[:existing_item][:id])
            if @item.id
               #if the item is found, then make a new location_items record to record the quantity of that item and that it is also at this location now too. 
               @location_item = LocationItem.new(location_item_params)
               @location_item.item_id = @item.id
               #I may need to check to see if there are any other location_item rows in the db that match the same location_id and item_id - if so, validation fails,
               if @location_item.save 
                  #If the location item entry saves, then tell the user it was successful and redirect to that location_item's path
                  flash[:notify] = "Your item was successfully created and added to #{@location.name}"
                  redirect_to location_items_path(@location)
               else
                  #if something went wrong with the saving of the location_item, display the errors to user and render out the new view
                  flash[:alert] = display_errors(@location_item)
                  render :new
               end
            else
               #if something went wrong with the saving of the item, display the errors to user and render out the new view
               flash[:alert] = display_errors(@item)
               render :new
            end
         #check to see if I'm dealing with a new item next
         elsif params[:item].present?
            @item = Item.new(item_params)

            #check to see if someone is trying to use the add new item input box to add an item that already exists with the same name for this user.
            #if the user wants to add to that item, they should just edit the quantity of the item. 
            #dupe_found = @user.items.find {|uitem| uitem.name == @item.name}
            if LocationItem.dupe_found(@user, @item)
               flash[:alert] = "#{@item.name} already exists. Edit the quantity at this location or use Add Existing Item when adding a new item."
               redirect_to location_items_path(@location)
            else
               #otherwise, set the new item to belong to the current user and save the item first 
               @item.user = @user
               if @item.save
                  # if the item saves, then create a location item entry and link it to this item and location
                  @location_item = LocationItem.new(location_item_params)
                  @location_item.item_id = @item.id
                  if @location_item.save 
                     #if the location item saves, then redirect the user to the location_items path and let them know it saved. 
                     flash[:notify] = "Your item was successfully created and added to #{@location.name}"
                     redirect_to location_items_path(@location)
                  else
                     #if something went wrong with the saving of the location_item, display the errors to user and render out the new view
                     flash[:alert] = display_errors(@location_item)
                     render :new
                  end
               else
                  #if something went wrong with the saving of the item, display the errors to user and render out the new view
                  flash[:alert] = display_errors(@item)
                  render :new
               end
            end
         end
      end
   end
   
   def show
      authorized?(resource_user_id: location_item_user_id)
   end
   
   def edit
      authorized?(resource_user_id: location_item_user_id)
   end
   
   def update
      authorized?(resource_user_id: location_item_user_id) do 
         #first update my item
         if @item.update(item_params)
            #now lets try to update the location item
            if @location_item.update(location_item_params)
               flash[:notify] = "Your item was successfully updated!"
               redirect_to location_item_path(@location, @location_item)
            else
               #something went wrong with updating the location item, display errors.
               flash[:alert] = display_errors(@location_item)
               redirect_to edit_location_item_path(@location, @location_item)
            end
         else
            #something went wrong with updating my item, display item errors.
            flash[:alert] = display_errors(@item)
            redirect_to edit_location_item_path(@location, @location_item)
         end
      end
   end
   
   def destroy_location_item_only
      #this will only destroy the location_item entry for the item (essentially just wiping out the stock of this item at a location); does not delete the item itself. 
      authorized?(resource_user_id: location_item_user_id) do 
         if @location_item.destroy
            flash[:notify] = "All stock of this item has been removed from this location."
            redirect_to location_items_path(@location)
         else
            flash[:alert] = display_errors(@location_item)
            render :show
         end
      end
   end

private
   def item_params
      params.require(:item).permit(:name, :description, :user_id)
   end

   def location_item_params
      params.require(:location_item).permit(:location_id, :quantity)
   end

   def set_location_by_location_id
      @location = Location.find_by_id(params[:location_id])
   end

   def set_item
      @item = @location_item.item
   end

   def set_location_item
      @location_item = LocationItem.find_by_id(params[:id])
   end

   def location_item_user_id
      @location_item.location.user.id
   end

end