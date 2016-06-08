class UserPassportsController < ApplicationController
  def create
    set_redirect
    up = UserPassport.new(user_passport_params)
    if up.save
      flash[:success] = "Added to Your Account!"
      redirect_to session[:redirect]
    else
      flash[:danger] = "You've already added that passport to your account!"
      redirect_to session[:redirect]
    end
  end

  private
    def user_passport_params
      params.permit(:passport_id, :user_id)
    end
end
