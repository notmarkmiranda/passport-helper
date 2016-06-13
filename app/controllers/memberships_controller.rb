class MembershipsController < ApplicationController
  def create
    @membership = Membership.new(membership_params)
    if @membership.save
      flash[:success] = "Yay!"
      redirect_to :back
    else
      flash[:danger] = "You're already part of this group."
      redirect_to :back
    end

  end

  def destroy
    group = Group.find(params[:id])
    current_user.groups.delete(params[:id])
    flash[:success] = "You're officially out of the #{group.name} group!"
    redirect_to session[:redirect]
  end

  private

  def membership_params
    params.permit(:user_id, :group_id)
  end
end
