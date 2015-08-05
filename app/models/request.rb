class Request < ActiveRecord::Base
  belongs_to :user

  enum status: [:pending, :cancel, :resolved]

  validates :book_title, presence: true
end
