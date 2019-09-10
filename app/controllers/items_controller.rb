class ItemsController < ApplicationController
   before_action :is_logged_in? #checks to see if a user is logged in for all actions
   before_action :current_user #sets @user for all actions
   before_action :set_location_by_location_id
   
   def index
      @items = @location.items
   end
   
   def new
   end
   
   def create
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
      params.require(:item).permit(:name, :description, :quantity)
   end

   def set_location_by_location_id
      @location = Location.find_by_id(params[:location_id])
   end

end