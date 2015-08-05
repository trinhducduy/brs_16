class Category < ActiveRecord::Base
  has_many :books, dependent: :destroy

  validates :name, presence: true, length: {minimum: 5}
  validates :description, presence: true, length: {minimum: 15}
end
