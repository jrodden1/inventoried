class SessionsController < ApplicationController
  # aka "new"
  def login
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:user][:email])

    if @user
      authenticated = @user.authenticate(params[:user][:password])

      if authenticated
        session[:user_id] = @user.id
        flash[:notify] = "Successfully Logged In!"
        redirect_to locations_path
      else
        flash[:notify] = "Incorrect Password"
        redirect_to login_path
      end
    else
      flash[:notify] = "Email not found"
      redirect_to login_path
    end

  end

  #aka destroy
  def logout
  end
end
