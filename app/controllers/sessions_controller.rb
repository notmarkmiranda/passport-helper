class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    begin
      @user = User.from_omniauth(request.env['omniauth.auth'])
      session[:user_id] = @user.id
      flash[:success] = "Welcome, #{@user.name}!"
      redirect_to user_dashboard_path
    rescue
      flash.now[:warning] = "That didn't work, try again."
      redirect_to root_path
    end
    # render text: request.env['omniauth.auth'].to_json
  end

  def create_from_email
    user = User.find_by(email: params[:session][:email], provider: "email")
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome #{user.name}!"
      redirect_to user_dashboard_path
    else
      flash.now[:warning] = "That didn't work, try again."
      render :new
    end
  end

  def destroy
    if current_user
      session.delete(:user_id)
      flash[:success] = "See you later!"
    end
    redirect_to root_path
  end
end
