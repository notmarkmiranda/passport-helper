class PassportsController < ApplicationController
  def index
    @passports = Passport.all
  end
end
