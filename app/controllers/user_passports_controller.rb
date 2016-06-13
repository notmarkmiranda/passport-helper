class UserPassportsController < ApplicationController
  def create
    up = UserPassport.new(user_passport_params)
    flash[:success] = "Added to Your Account!" if up.save
    redirect_to session[:redirect]
  end

  def destroy
    passport = Passport.find(params[:id])
    current_user.passports.destroy(params[:id])
    flash[:success] = "Removed #{passport.name} from your account!"
    redirect_to session[:redirect]
  end

  private
  def user_passport_params
    params.permit(:passport_id, :user_id)
  end
end
