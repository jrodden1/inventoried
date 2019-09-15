class ApplicationController < ActionController::Base
   #displays errors the object fed to it. 
   def display_errors(object)
      object.errors.full_messages.join(", ")
   end

   #gets the current user - used mainly by my controllers
   def current_user
      @user = User.find_by_id(session[:user_id])
   end
   
   #checks to see if a user is logged in - used mainly by my controllers
   def is_logged_in?
      if !!session[:user_id] 
         true
      else 
         flash[:alert] = "You must be logged in to view this resource"
         redirect_to login_path
      end
   end

   #my authorization watchdog method - checks to make sure that the user that is trying to do an action is the one who owns that resource.
   def authorized?(current_user_id: @user.id, resource_user_id:, redirect_if_logged_in_path: locations_path)
      #my legitimacy checker - are you the real sparticus? 
      if current_user_id == resource_user_id
         #you are the real sparticus, do as you wish.
         yield if block_given?
      else
         #Nay, you are an imposter!  you shall be redirected accordingly.
         flash[:alert] = "You are not authorized to perform this action"

         if is_logged_in? 
            redirect_to redirect_if_logged_in_path
         else
            redirect_to login_path
         end
      end
   end 
end
