class LocationsController < ApplicationController
   before_action :is_logged_in?
   before_action :current_user

   def index
      @locations = @user.locations
   end
   
   def new
      @location = Location.new
   end
   
   def create
      @location = Location.new(location_params)
      binding.pry
      authorized?(@user.id, @location.user_id) do 
         if @location.save
            flash[:notify] = "#{@location.name} successfully created!"
            redirect_to location_path(@location)
         else
            flash[:notify] = display_errors(@location)
            render :new
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
   
   def location_params
      params.require(:location).permit(:name, :user_id, :item_id)
   end
   
end
