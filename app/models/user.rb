class User < ApplicationRecord
    has_many :posts, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :likes, dependent: :destroy
    has_many :liked_posts, through: :likes, source: :post
    has_many :active_notifications, class_name: 'Notification', foreign_key: 'visiter_id', dependent: :destroy
    has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
    attr_accessor :remember_token
    before_save { self.email = email.downcase }
    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: true }, format: { with: VALID_EMAIL_REGEX}
    validates :password, length: { minimum: 6 }
    has_secure_password
    has_one_attached :image
    validate :image_size


    #ランダムな文字列作
    def User.new_token
        SecureRandom.urlsafe_base64
    end

    #渡された文字列をハッシュ化
    def User.digest(string)
        BCrypt::Password.create(string)
    end

    #ハッシュ化した文字列をDBに保存
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end

    #渡された文字列がremember_digestと一致するか？
    def authenticated?(remember_token)
        return false if remember_digest.nil?

        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

    #remember_digestをDBから消す
    def forget
        update_attribute(:remember_digest, nil)
    end

    #画像の検証
    def image_size
        return unless image.attached?
        
        if image.blob.byte_size > 10.megabytes
            image = nil
            errors.add(:image, "10MB以下にしてください")
        elsif !image?
            image = nil
            errors.add(:image, "ファイルタイプが無効です")
        end
    end

    #投稿に対していいねしたかどうか
    def already_likes?(post)
        self.likes.exists?(post_id: post.id)
    end

    def image?
        %w[image/jpg image/jpeg image/gif image/png].include?(image.blob.content_type)
    end
end
