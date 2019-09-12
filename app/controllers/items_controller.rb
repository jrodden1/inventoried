class ItemsController < LocationItemsController
   before_action :is_logged_in? #checks to see if a user is logged in for all actions
   before_action :current_user
   before_action :set_item, only: [:show, :edit, :update, :destroy_item_from_all_locations]

   def index
      if params[:query].present?
         #create scope method out of this line below. needs chainable - with like sort for example.
         @items = Item.where("user_id = ? AND name LIKE ?", @user.id, "%#{params[:query]}%")
         
         if @items.empty?
            @no_results = "Your search returned no results"
            @items = @user.items
         end
      else 
         @items = @user.items
      end
   end
   
   def new
      #allow me to create a new item and assign it to an existing location
      #otherwise, prompt the user to create a location first
   end
   
   def create
   end
   
   def show
      authorized?(resource_user_id: @item.user.id, redirect_if_logged_in_path: items_path) do
      #show the item itself and all the locations it is in (with associated quantities) Display total amount 
      #i already have @item at this point because of before_action
         @locations = @item.locations
      end
   end
   
   def edit 
      #MVP allow only edits of the actual location name 
   end
   
   def update
      #update only the name; later on could add the ability to manage inventory / transfer inventory between locations
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

