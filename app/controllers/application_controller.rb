class ApplicationController < ActionController::Base

   #this might need to go into a helper actuall - REFACTOR
   def display_errors(object)
      object.errors.full_messages.join("\n")
   end

   def current_user
      @user = User.find_by_id(session[:user_id])
   end
   
   def is_logged_in?
      if !!session[:user_id] 
         true
      else 
         flash[:notify] = "You must be logged in to view this resource"
         redirect_to login_path
      end
   end

   def authorized?(current_user_obj=@user, resource_user_id)
     current_user_obj.id == resource_user_id
   end 

end
