class Relationship < ActiveRecord::Base
  include Loggable

  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  validates :follower_id, uniqueness: {scope: :followed_id}

  after_create :create_relationship_log

  private
  def create_relationship_log
    create_activity_log follower_id, followed_id, Settings.activities.follow
    create_activity_log followed_id, follower_id, Settings.activities.followed
  end
end
