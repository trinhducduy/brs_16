class Request < ActiveRecord::Base
  belongs_to :user

  enum status: [:pending, :cancel, :rejected, :resolved]

  validates :book_title, presence: true

  scope :latest, ->{order created_at: :desc}

  after_save :send_accept_request_email

  private
  def send_accept_request_email
    if self.resolved?
      UserMailer.notify_accept_book_request(self).deliver
    end
  end
end
