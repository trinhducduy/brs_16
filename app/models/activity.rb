class Activity < ActiveRecord::Base
  belongs_to :user
  has_many :activity_likes, dependent: :destroy
end
