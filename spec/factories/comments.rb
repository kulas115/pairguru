FactoryBot.define do
  factory :comment do
    content Faker::Lorem.sentence
    movie
    user
  end
end
