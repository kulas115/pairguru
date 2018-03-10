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
    trait :with_one_comment do
      after(:create) do |user|
        create_list :comment, 1, user: user
      end
    end
    trait :with_two_comments do
      after(:create) do |user|
        create_list :comment, 2, user: user
      end
    end
    trait :with_three_comments do
      after(:create) do |user|
        create_list :comment, 3, user: user
      end
    end
    trait :with_old_comments do
      after(:create) do |user|
        create_list :comment, 3, user: user, created_at: 10.days.ago
      end
    end
  end
end
