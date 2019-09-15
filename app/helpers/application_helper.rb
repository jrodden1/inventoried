module ApplicationHelper
   #view specific helpers that differ slightly from their sisters in the application controller
   def is_logged_in?
      !!session[:user_id] 
   end

   def current_user
      User.find_by_id(session[:user_id])
   end

end
