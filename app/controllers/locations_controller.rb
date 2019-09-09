class LocationsController < ApplicationController
   before_action :is_logged_in? #checks to see if a user is logged in for all actions
   before_action :current_user #sets @user for all actions
   before_action :set_location, only: [:show, :edit, :destroy] #sets @location for show, edit, update, and destory

   def index
      @locations = @user.locations
   end
   
   def new
      @location = Location.new
   end
   
   def create
      create_dummy_location_for_checking
      
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
      authorized?(resource_user_id: @location.user_id)
   end
   
   def update
      create_dummy_location_for_checking

      authorized?(resource_user_id: @location.user_id) do 
         if set_location
            @location.update(name: location_params[:name])
            flash[:notify] = "Location name successfully updated!"
            redirect_to location_path(@location)
         else
            flash[:notify] = display_errors(@location)
            render :edit
         end
      end
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

   def create_dummy_location_for_checking
      @location = Location.new(location_params)
   end
   
end
