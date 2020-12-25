class User < ApplicationRecord
    has_many :posts, dependent: :destroy
    has_many :comments, dependent: :destroy
    attr_accessor :remember_token
    before_save { self.email = email.downcase }
    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 }, uniqueness: true, format: { with: VALID_EMAIL_REGEX}
    validates :password, length: { minimum: 6 }
    has_secure_password
    has_one_attached :image

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
end
