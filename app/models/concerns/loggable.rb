module Loggable
  extend ActiveSupport::Concern

  private
  def create_activity_log user_id, target_id, action_type
    Activity.create user_id: user_id, target_id: target_id,
      action_type: action_type
  end
end
