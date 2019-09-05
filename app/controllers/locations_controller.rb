class LocationsController < ApplicationController

   def index
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
   
   def location_params
      params.require(:location).permit(:name, :user_id, :item_id)
   end
   
end
