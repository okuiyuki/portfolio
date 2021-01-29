class Category < ApplicationRecord
    has_many :posts
    validates :name, presence: true

    
    def self.change_order
        @categories = Category.all.map { |o| [o.name, o.id]}
        @categories[3] = ["---カテゴリ---",""]
        @categories.reverse!
    end
end
