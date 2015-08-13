class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :user_books, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :activity_likes, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
    foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
    foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: "followed"
  has_many :followeds, through: :passive_relationships, source: "follower"

  mount_uploader :avatar, AvatarUploader

  enum role: [:member, :admin]

  validates :name, presence: true, length: {minimum: 6}

  scope :has_reviewed_or_commented_on, ->book, user{joins(:comments)
    .joins("JOIN reviews ON comments.review_id = reviews.id OR reviews.user_id = users.id")
    .where("reviews.book_id = ? AND users.id != ?", book.id, user.id).distinct}
end
