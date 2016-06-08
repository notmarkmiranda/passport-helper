class PassportsController < ApplicationController
  def index
    @active_passports = Passport.active_passports
    @inactive_passports = Passport.inactive_passports
  end

  def show
    @passport = Passport.find_by(id: params[:id])
    @venues = @passport.venues
  end

end
