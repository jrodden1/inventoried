class UsersController < ApplicationController
  
  # this is the new route 
  def signup
  
  end

  def create
  
  end

  def show
  end

  def edit
  end

  #Also need to add the facebook omniauth route etc.  

private

  def user_params
    params.require(:user).permit(:name, :email, :password, :uid)
  end
  
end
