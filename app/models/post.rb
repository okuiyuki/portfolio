class Post < ApplicationRecord
  belongs_to :category
  belongs_to :user
  validates :title, presence: true, length: { maximum: 50 }
  validates :discription, presence: true
  defult_scope -> { order(created_at: :desc)}
end
