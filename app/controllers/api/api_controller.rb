class Api::ApiController < ApplicationController
  # inheriting, gets access to application controller
  # but can change definitions
  # protect from forgery
  protect_from_forgery with: :null_session

end
