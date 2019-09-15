class StaticController < ApplicationController
  def home
    #if the user is already logged in, when they try to go to the homepage they will get redirected to their locations path
    if !!session[:user_id]
      redirect_to locations_path
    end
  end
end
