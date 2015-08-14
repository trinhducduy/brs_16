class Review < ActiveRecord::Base
  include Loggable

  before_create :create_review_log
  after_save :caculate_average_rating

  belongs_to :user
  belongs_to :book
  has_many :comments, dependent: :destroy

  validates :content, presence: true
  validates :user_id, uniqueness: {scope: :book_id}

  after_create :inform_new_review

  private
  def create_review_log
    create_activity_log user_id, book_id, Settings.activities.review
  end

  def caculate_average_rating
    reviews = book.reviews
    sum = reviews.map{|review| review[:rating]}.reduce(:+)
    book.update_attributes average_rating: (sum / reviews.size)
  end

  def inform_new_review
    users = User.has_reviewed_or_commented_on book, user
    users.each do |user|
      UserMailer.delay.notify_review_email user, book, self
    end
  end
end
