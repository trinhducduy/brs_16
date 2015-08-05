class UserBook < ActiveRecord::Base
  belongs_to :user
  belongs_to :book

  enum status: [:not_read, :reading, :read]

  validates :user_id, uniqueness: {scope: :book_id}
end
