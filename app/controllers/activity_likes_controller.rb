class ActivityLikesController < ApplicationController
  before_action :load_activity, only: [:create, :destroy]

  respond_to :js

  def create
    activity_like = @activity.activity_likes.build user_id: current_user.id
    unless activity_like.save
      flash[:danger] = "application.flash.something_wrong"
    end
  end

  def destroy
    activity_like = ActivityLike.find_by user_id: current_user.id,
      activity_id: @activity.id
    unless activity_like.destroy
      flash[:danger] = "application.flash.something_wrong"
    end
  end

  private
  def load_activity
    @activity = Activity.find params[:activity_id]
  end
end
