FactoryBot.define do
  factory :news_article do
    title Faker::Book.title
    description Faker::Company.catch_phrase
  end
end
