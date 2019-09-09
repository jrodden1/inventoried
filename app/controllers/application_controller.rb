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

   def authorized?(current_user_id: @user.id, resource_user_id:)
      if current_user_id == resource_user_id
         yield if block_given?
      else
         flash[:notify] = "You are not authorized to perform this action"

         if is_logged_in? 
            redirect_to locations_path
         else
            redirect_to login_path
         end
      end
   end 

end
