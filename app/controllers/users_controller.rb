class UsersController < ApplicationController
  
  # This is the "new" route essentially
  def signup
    @user = User.new
  end

  def create
    @user = User.create(user_params)

    if @user.id
      flash[:notify] = "Account Successfully Created.\nYou have also been logged in."
      session[:user_id] = @user.id
      
      #the user's "home page" is the locations page
      redirect_to locations_path
    else
      flash[:alert] = "Errors detected! #{display_errors(@user)}"
      render :signup
    end
  end

  #not implementing these as of now in the MVP. 
  # def show
  # end

  # def edit
  # end

private

  def user_params
    params.require(:user).permit(:name, :email, :password, :uid)
  end
  
end
