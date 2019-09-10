class ItemsController < ApplicationController
   before_action :is_logged_in? #checks to see if a user is logged in for all actions
   before_action :current_user #sets @user for all actions
   before_action :set_location_by_location_id
   
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
   end
   
   def edit 
   end
   
   def update
   end
   
   def destroy
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

end