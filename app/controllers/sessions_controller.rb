class SessionsController < ApplicationController
  
  def login # aka a customized "new" action
    @user = User.new
  end

  def create
    #check to see if its a facebook login first
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
    else #login with Inventoried account 
      @user = User.find_by(email: params[:user][:email])
      if @user && @user.authenticate(params[:user][:password])
        session[:user_id] = @user.id
        flash[:notify] = "Successfully Logged In!"
        redirect_to locations_path
      else
        @user = User.new
        flash.now[:alert] = "Incorrect Username or Password"
        render :login
      end
    end
  end

  #aka destroy
  def logout
    session.destroy
    redirect_to login_path
  end

private

  #used for omniauth facebook
  def auth
    request.env['omniauth.auth']
  end
  
end
