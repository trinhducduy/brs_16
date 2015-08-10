class UserBook < ActiveRecord::Base
  include Loggable

  belongs_to :user
  belongs_to :book

  enum status: [:not_read, :reading, :read]

  validates :user_id, uniqueness: {scope: :book_id}

  before_save :create_user_book_log

  private
  def create_user_book_log
    if self.status_changed?
      action_type = self.read? ? Settings.activities.read : Settings.activities.reading
      create_activity_log user_id, book_id, action_type
    end

    if self.favored_changed?
      create_activity_log(user_id, book_id,
        Settings.activities.favored) if self.favored?
    end
  end
end
