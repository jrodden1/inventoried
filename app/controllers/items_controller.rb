class ItemsController < ApplicationController
   before_action :is_logged_in? #checks to see if a user is logged in for all actions
   before_action :current_user #sets @user for all actions
   before_action :set_location_by_location_id
   before_action :set_item, only: [:show, :edit, :update, :destory]
   before_action :set_location_item, only: [:show, :edit, :update, :destory]
   
   def index
      
      @items = @location.items
   end
   
   def new
      @item = @location.items.build
      @location_item = @location.location_items.build
      #this could use some refactoring but it works. 
      @user_items = Item.all.select do |item|
         item.users.first.id == @user.id
         #I don't like this piece of code -- need to refactor this so that there is a belongs_to of item to user
      end.reject {|item| @location.items.find_by(name: item.name)}
   end
   
   def create
      #This create method should probably be cleaned up into some helper methods - looks kind of huuuuugee 
      authorized?(resource_user_id: @location.user_id) do 
         if params[:existing_item].present?
            @item = Item.find_by_id(params[:existing_item][:id])
            if @item.id
               @location_item = LocationItem.new(location_item_params)
               @location_item.item_id = @item.id
               #I may need to check to see if there are any other location_item rows in the db that match the same location_id and item_id - if so, validation fails,
               if @location_item.save 
                  flash[:notify] = "Your item was successfully created and added to #{@location.name}"
                  redirect_to location_items_path(@location)
               else
                  flash[:notify] = display_errors(@location_item)
                  render :new
               end
            else
               flash[:notify] = display_errors(@item)
               render :new
            end

         elsif params[:item].present?
            @item = Item.new(item_params)

            if @item.save
               @location_item = LocationItem.new(location_item_params)
               @location_item.item_id = @item.id
               if @location_item.save 
                  flash[:notify] = "Your item was successfully created and added to #{@location.name}"
                  redirect_to location_items_path(@location)
               else
                  flash[:notify] = display_errors(@location_item)
                  render :new
               end
            else
               flash[:notify] = display_errors(@item)
               render :new
            end
         end
      end
   end
   
   def show
      authorized?(resource_user_id: @location.user_id)
   end
   
   def edit 
      authorized?(resource_user_id: @location.user_id)
   end
   
   def update
      #should possibly switch the resource_user_id to @item.users.first.id
      authorized?(resource_user_id: @location.user_id) do 
         if @item.update(item_params)
            if @location_item.update(location_item_params)
               flash[:notify] = "Your item was successfully updated!"
               redirect_to location_item_path(@location, @item)
            else
               flash[:notify] = display_errors(@location_item)
               redirect_to edit_location_item(@location, @item)
            end
         else
            flash[:notify] = display_errors(@item)
            redirect_to edit_location_item(@location, @item)
         end
      end
   end
   
   def destroy_location_item_only
      # So my pickle here is this... I need an option to destory just the stock for an item AND an option to destroy the item completely from all stock at all locations.
      binding.pry
      authorized?(resource_user_id: @location.user_id) do 
         if @location_item.destroy
            flash[:notify] = "All stock has been removed for this location."
            redirect_to location_items_path(@location)
         else
            flash[:notify] = display_errors(@location_item)
            render :show
         end
      end
   end

   def destroy_item_from_all_locations
      #need to make sure that @item.destroy will destroy all the associated @location_item entries
      authorized?(resource_user_id: @location.user_id) do 
         #nothing right now.  Need to figure this out tomorrow -- may need to use .destroy_all? or what ever will ripple delete
      end
   end
   

private
   def item_params
      params.require(:item).permit(:name, :description)
   end

   def location_item_params
      params.require(:location_item).permit(:location_id, :quantity)
   end

   def set_location_by_location_id
      @location = Location.find_by_id(params[:location_id])
   end

   def set_item
      @item = Item.find_by_id(params[:id])
   end

   def set_location_item
      @location_item = LocationItem.find_by(location_id: params[:location_id], item_id: params[:id])
   end

end