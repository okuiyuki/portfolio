class Post < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  validates :title, presence: true, length: { maximum: 50 }
  validates :discription, presence: true
  default_scope -> { order(created_at: :desc) }
  has_many_attached :images
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps

  #いいねの通知作成
  def create_notification_like!(current_user)
    temp = Notification.where(['visiter_id = ? and visited_id = ? and post_id = ? and action = ?', current_user.id, user_id, id, 'like'])
    if temp.blank?
      notification = Notification.new(
        post_id: id,
        visited_id: user_id,
        visiter_id: current_user.id,
        action: 'like'
      )
      notification.checked = true if notification.visiter_id == notification.visited_id
      notification.save if notification.valid?
    end
  end

  #コメントの通知作成
  def create_notification_comment!(current_user, comment_id)
    temp_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).uniq
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  #通知作成
  def save_notification_comment!(current_user, comment_id, visited_id)
    notification = Notification.new(
      post_id: id,
      visited_id: visited_id,
      visiter_id: current_user.id,
      comment_id: comment_id,
      action: 'comment'
    )
    notification.checked = true if notification.visiter_id == notification.visited_id
    notification.save if notification.valid?
  end

  #タグの保存
  def save_tags(tag_list)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - tag_list
    new_tags = tag_list - current_tags

    old_tags.each do |old_tag|
      self.tags.delete Tag.find_by(tag_name: old_tag)
    end

    new_tags.each do |new_tag|
      post_new_tag = Tag.find_or_create_by(tag_name: new_tag)
      self.tags << post_new_tag
    end
  end
end
