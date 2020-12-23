class Category < ApplicationRecord
    has_many :posts

    def self.change_order
        @categories = Category.all.map { |o| [o.name, o.id]}
        @categories[3] = ["---選択してください---",""]
        @categories.reverse!
    end
end
