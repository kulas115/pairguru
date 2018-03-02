FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    name { Faker::Internet.user_name }
    confirmed_at { Time.zone.now}
    password 'foobarfoobar'

    trait :with_comments do
      after(:create) do |user|
        create_list :comment, 5, user: user
      end
    end
  end
end
