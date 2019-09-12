class SessionsController < ApplicationController
  # aka "new"
  def login
    @user = User.new
  end

  def create
    binding.pry
    
    # @user = User.find_or_create_by(uid: auth['uid']) do |u|
    #   u.name = auth['info']['name']
    #   u.email = auth['info']['email']
    #   u.image = auth['info']['image']
    # end
  
    # session[:user_id] = @user.id
    
    @user = User.find_by(email: params[:user][:email])

    if @user
      authenticated = @user.authenticate(params[:user][:password])

      if authenticated
        session[:user_id] = @user.id
        flash[:notify] = "Successfully Logged In!"
        redirect_to locations_path
      else
        flash[:alert] = "Incorrect Password"
        redirect_to login_path
      end
    else
      flash[:alert] = "Email not found"
      redirect_to login_path
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
