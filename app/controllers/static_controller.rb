class StaticController < ApplicationController
  def home
    if !!session[:user_id]
      redirect_to locations_path
    end
  end
end
