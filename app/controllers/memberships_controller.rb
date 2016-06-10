class MembershipsController < ApplicationController
  def destroy
    set_redirect
    group = Group.find(params[:id])
    current_user.groups.delete(params[:id])
    flash[:success] = "You're officially out of the #{group.name} group!"
    redirect_to session[:redirect]
  end
end
