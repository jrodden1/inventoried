class SessionsController < ApplicationController
  # aka "new"
  def login
    @user = User.new
  end

  def create
    binding.pry
    if auth 
      @user = User.find_or_create_by_facebook_omniauth(auth) 
      if @user.id 
        session[:user_id] = @user.id
        flash[:notify] = "Successfully Logged In!"
        redirect_to locations_path
      else
        flash[:alert] = display_errors(@user)
        render :login
      end
    else 
      #login with Inventoried account
      @user = User.find_by(email: params[:user][:email])
      if @user && @user.authenticate(params[:user][:password])
        session[:user_id] = @user.id
        flash[:notify] = "Successfully Logged In!"
        redirect_to locations_path
      else
        flash[:alert] = "Incorrect Username or Password"
        render :login
      end
    end
  end

  #aka destroy
  def logout
    session.delete :user_id
    redirect_to login_path
  end

private

  def auth
    request.env['omniauth.auth']
  end
  
end
