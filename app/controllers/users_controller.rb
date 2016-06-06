class UsersController < ApplicationController

  def new
  end

  def create
    set_redirect
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Thanks for signing up!"
      redirect_to user_dashboard_path
    else
      flash[:warning] = @user.errors.full_messages.join("<br />").html_safe
      redirect_to session[:redirect]
    end
  end

  def complete
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    @user.finish_registration(user_params)
    redirect_to user_dashboard_path
  end

  private

    def user_params
      params.require(:user).permit(:provider, :email, :password, :name, :image_url)
    end

end
