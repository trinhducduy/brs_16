class Review < ActiveRecord::Base
  include Loggable

  belongs_to :user
  belongs_to :book
  has_many :comments, dependent: :destroy

  validates :content, presence: true
  validates :user_id, uniqueness: {scope: :book_id}

  before_create :create_review_log

  private
  def create_review_log
    create_activity_log user_id, book_id, Settings.activities.review
  end
end
