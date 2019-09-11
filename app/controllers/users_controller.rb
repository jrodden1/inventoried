class UsersController < ApplicationController
  
  # this is the new route 
  def signup
    @user = User.new
  end

  def create
    @user = User.create(user_params)

    if @user.id
      flash[:notify] = "Account Successfully Created.\nYou have also been logged in."
      session[:user_id] = @user.id
      redirect_to locations_path
    else
      flash[:alert] = "Errors detected!\n#{display_errors(@user)}"
      render :signup
    end
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
