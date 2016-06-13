class SessionsController < ApplicationController

  def create
    begin
      @user = User.from_omniauth(request.env['omniauth.auth'])
      session[:user_id] = @user.id
      flash[:success] = "Welcome, #{@user.name}!"
      redirect_to root_path
    rescue
      flash.now[:warning] = "That didn't work, try again."
      redirect_to :back
    end
  end

  def create_from_email
    user = User.find_by(email: params[:session][:email], provider: "email")
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome #{user.name}!"
      redirect_to :back
    else
      flash[:warning] = "That didn't work, try again."
      redirect_to :back
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:success] = "See you later!"
    redirect_to root_path
  end
end
