class LocationsController < ApplicationController
   before_action :is_logged_in? #checks to see if a user is logged in for all actions
   before_action :current_user #sets @user for all actions
   before_action :set_location, only: [:show, :edit, :update, :delete] #sets @location for show, edit

   def index
      @locations = @user.locations
   end
   
   def new
      @location = Location.new
   end
   
   def create
      @location = Location.new(name: params[:location][:name], user_id: session[:user_id])
      #I may need to refactor the form here to just remove the hidden input for user_id and just make 'location_params' just the name parameter

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
      authorized?(resource_user_id: @location.user_id) do 
         if @location.update(name: location_params[:name])
            flash[:notify] = "Location name successfully updated!"
            redirect_to location_path(@location)
         else
            flash[:notify] = display_errors(@location)
            redirect_to location_path(@location)
         end    
      end
   end
   
   def destroy
      authorized?(resource_user_id: @location.user_id) do 
         if @location.items.empty?
            if @location.destroy
               flash[:notify] = "Location successfully deleted"
               redirect_to locations_path
            else
               flash[:notify] = display_errors(@location)
               render :show
            end
         else
            flash[:notify] = "This location still contains items.  Please delete all items belonging to this location before deleting this location"
            redirect_to location_path(@location)
         end
      end
   end

private
   
   def location_params
      params.require(:location).permit(:name, :user_id)
   end
   
   def set_location
      @location = Location.find_by_id(params[:id])
   end
   
end
