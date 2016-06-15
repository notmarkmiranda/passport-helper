class AdminController < ApplicationController
  before_action :require_admin

  def show
    @users = User.all
    @ups = UserPassport.all
    @groups = Group.all
    @passports = Passport.all
    @venues = Venue.all
    @visits = Visit.all
  end
end
