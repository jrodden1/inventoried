class ApplicationController < ActionController::Base

   #this might need to go into a helper actuall - REFACTOR
   def display_errors(object)
      object.errors.full_messages.join("\n")
   end
end
