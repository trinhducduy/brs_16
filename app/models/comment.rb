class Comment < ActiveRecord::Base
  include Loggable

  belongs_to :user
  belongs_to :review

  validates :content, presence: true

  before_create :create_comment_log

  scope :lastest, ->{order created_at: :desc}

  after_create :inform_new_comment

  private
  def create_comment_log
    create_activity_log user_id, review.book.id, Settings.activities.comment
  end

  def inform_new_comment
    book = review.book
    users = User.has_reviewed_or_commented_on book, user
    users.each do |user|
      UserMailer.delay.notify_comment_email user, book, self
    end
  end
end
