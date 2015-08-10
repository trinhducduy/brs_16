class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :review

  validates :content, presence: true

  before_create :create_comment_log

  private
  def create_comment_log
    create_activity_log user_id, review.book.id, Settings.activities.comment
  end
end
