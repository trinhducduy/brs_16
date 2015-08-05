class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :book
  has_many :comments, dependent: :destroy

  validates :content, presence: true
  validates :user_id, uniqueness: {scope: :book_id}
end
