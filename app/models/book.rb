class Book < ActiveRecord::Base
  belongs_to :category
  has_many :reviews, dependent: :destroy
  has_many :user_books, dependent: :destroy

  validates :title, presence: true
  validates :published_date, presence: true
  validates :author, presence: true
  validates :description, presence: true
  validates :number_of_page, presence: true, numericality: {minimum: 1}
end
