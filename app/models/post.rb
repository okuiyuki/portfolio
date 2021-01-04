class Post < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :title, presence: true, length: { maximum: 50 }
  validates :discription, presence: true
  default_scope -> { order(created_at: :desc)}

  has_many_attached :images
  has_many :likes, dependent: :destroy
end
