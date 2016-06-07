class PassportsController < ApplicationController
  def index
    @active_passports = Passport.active_passports
    @inactive_passports = Passport.inactive_passports
  end
end
