class LocationsController < ApplicationController
   before_action :is_logged_in? #checks to see if a user is logged in for all actions
   before_action :current_user #sets @user for all actions
   before_action :set_location, only: [:show, :edit, :update, :destroy] #sets @location for show, edit, update, and destory

   def index
      @locations = @user.locations
   end
   
   def new
      @location = Location.new
   end
   
   def create
      @location = Location.new(location_params)
      
      authorized?(resource_user_id: @location.user_id) do 
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
      authorized?(resource_user_id: @location.user_id)
   end
   
   def edit
      
   end
   
   def update
   end
   
   def destroy
   end

private
   
   def location_params
      params.require(:location).permit(:name, :user_id)
   end
   
   def set_location
      @location = Location.find_by_id(params[:id])
   end

end
