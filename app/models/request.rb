class Request < ActiveRecord::Base
  belongs_to :user

  enum status: [:pending, :cancel, :rejected, :resolved]

  validates :book_title, presence: true

  scope :latest, ->{order created_at: :desc}
end
