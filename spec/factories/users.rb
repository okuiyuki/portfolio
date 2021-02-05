FactoryBot.define do
  factory :user do
    name { "testuser" }
    sequence(:email) { |n| "test#{n}@gmail.com"}
    password { "password" }
    password_confirmation { "password" }

  end
end

# after(:build) do |user|
#   user.image.attach(io: File.open('app/assets/images/user_default.png'), filename: 'user_default.ong')
# end
