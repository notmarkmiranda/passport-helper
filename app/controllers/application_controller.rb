class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_redirect
  private


  helper_method :current_user, :set_redirect, :current_admin?
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def require_user
    unless current_user
      flash[:danger] = "You can't do that until you get logged in!"
      redirect_to root_path
    end
  end

  def set_redirect
    session[:redirect] = request.referer
  end

  def current_admin?
    current_user && current_user.admin?
  end

  def require_admin
    redirect_to errors_404_path unless current_admin?
  end
end
