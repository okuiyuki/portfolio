class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :post_id, presence: true
  validates :user_id, presence: true
  validates_uniqueness_of :post_id, scope: :user_id

  
end
