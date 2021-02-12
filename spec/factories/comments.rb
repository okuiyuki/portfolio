FactoryBot.define do
  factory :comment do
    body { 'コメントです' }
    association :post
    user { post.user }
  end
end
