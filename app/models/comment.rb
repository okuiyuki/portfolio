class Comment < ApplicationRecord
  has_many :notifications, dependent: :destroy
  belongs_to :user
  belongs_to :post
  validates :body, presence: true, length: { maximum: 255 }
  default_scope -> { order(created_at: :desc) }
end
