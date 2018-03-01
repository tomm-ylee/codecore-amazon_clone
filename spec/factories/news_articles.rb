FactoryBot.define do
  factory :news_article do
    sequence(:title) { |n| Faker::Book.title + " #{n}" }
    description Faker::Company.catch_phrase
    association(:user) { FactoryBot.create(:user) }
  end
end
