class Activity < ActiveRecord::Base
  belongs_to :user
  has_many :activity_likes, dependent: :destroy
  has_many :liked_users, through: :activity_likes,
    class_name: "User", source: :user

  before_create :create_target_name

  private
  def find_target
    case action_type
    when Settings.activities.follow, Settings.activities.followed
      User.find_by id: target_id
    when Settings.activities.read, Settings.activities.reading,
      Settings.activities.favored, Settings.activities.review
      Book.find_by id: target_id
    else
      nil
    end
  end

  def create_target_name
    target = find_target
    if target.is_a? User
      self.target_name = target.name
    elsif target.is_a? Book
      self.target_name = target.title
    else
      self.target_name = ""
    end
  end
end
