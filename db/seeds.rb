# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
 user1 = User.create!(
    name: "aaaa",
    email: "aaaaa@gmail.com",
    password: "aaaaaa",
    password_confirmation: "aaaaaa"
)
image_path = Rails.root.join('app/assets/images/user_default.png')
user1.image.attach(io: File.open(image_path), filename: 'user_default.png')

Category.create!(name: "フロントエンド")
Category.create!(name: "バックエンド")
Category.create!(name: "インフラ")