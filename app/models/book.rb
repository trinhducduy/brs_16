class Book < ActiveRecord::Base
  include Bootsy::Container

  belongs_to :category
  has_many :reviews, dependent: :destroy
  has_many :user_books, dependent: :destroy

  mount_uploader :image, CoverUploader

  validates :title, presence: true
  validates :published_date, presence: true
  validates :author, presence: true
  validates :description, presence: true
  validates :number_of_page, presence: true, numericality: {minimum: 1}
  validates :category, presence: true
  validate :published_date_must_be_less_than_today

  scope :read_by, ->user{joins(:user_books).where("user_books.user_id = ? AND
    user_books.status = ?", user.id, UserBook.statuses[:read])}
  scope :favored_by, ->user{joins(:user_books).where("user_books.user_id = ?
    AND user_books.favored = ?", user.id, true)}

  private
  def published_date_must_be_less_than_today
    errors.add :published_date,
      I18n.t("application.messages.wrong_date") if self.published_date.to_date > Date.today
  end

  def self.ransackable_attributes auth_object = nil
    if auth_object == :admin
      super
    else
      super & %w(title author description published_date)
    end
  end
end
