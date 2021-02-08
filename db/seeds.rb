user1 = User.create!(
    name: "aaaa",
    email: "aaaaa@gmail.com",
    password: "aaaaaa",
    password_confirmation: "aaaaaa"
)

user2 = User.create!(
    name: "bbbb",
    email: "bbbbb@gmail.com",
    password: "bbbbbb",
    password_confirmation: "bbbbbb"
)
image_path = Rails.root.join('app/assets/images/user_default.png')
user1.image.attach(io: File.open(image_path), filename: 'user_default.png')
user2.image.attach(io: File.open(image_path), filename: 'user_default.png')

Category.create!(name: "フロントエンド")
Category.create!(name: "バックエンド")
Category.create!(name: "インフラ")