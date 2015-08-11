class RelationshipsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @user = User.find params[:relationship][:user_id]
    unless current_user.active_relationships.create followed_id: @user.id
      flash[:danger] = t "application.flash.something_wrong"
    end
    respond_to do |format|
      format.html{redirect_to @user}
      format.js{render "relationships/relationship"}
    end
  end

  def destroy
    relationship = Relationship.find params[:id]
    @user = relationship.followed
    unless relationship.destroy
      flash[:danger] = t "application.flash.something_wrong"
    end
    respond_to do |format|
      format.html{redirect_to @user}
      format.js{render "relationships/relationship"}
    end
  end
end
