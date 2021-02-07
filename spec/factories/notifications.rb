FactoryBot.define do
  factory :notification do
    association :visiter, factory: :user
    association :visited, factory: :user
    action { 'like' }
    checked { false }
  end
end
