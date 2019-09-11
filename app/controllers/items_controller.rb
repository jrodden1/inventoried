class ItemsController < LocationItemsController
   before_action :is_logged_in? #checks to see if a user is logged in for all actions
   before_action :current_user
   before_action :set_item, only: [:show, :edit, :update, :destroy_item_from_all_locations]

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
#Add this funcationality if later - REFACTOR -- probably place it under a route of just localhost:3000/items - which will show all the items owned and which locations they are in.  
   def destroy_item_from_all_locations
      #need to make sure that @item.destroy will destroy all the associated @location_item entries
      authorized?(resource_user_id: @location.user_id) do 
         #nothing right now.  Need to figure this out tomorrow -- may need to use .destroy_all? or what ever will ripple delete
      end
      # DO NOT FORGET TO UPDATE routes.rb to reflect these new actions
   end


end

