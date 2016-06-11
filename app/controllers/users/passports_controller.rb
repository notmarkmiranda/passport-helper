class Users::PassportsController < ApplicationController
  def show
    @passport = Passport.find(params[:id])
    @venues = @passport.venues
    @up = UserPassport.find_by(user_id: params[:user_id], passport_id: params[:id])
    @visits = YelpVenue.up_visits(@up)
  end
end
