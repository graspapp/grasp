FactoryGirl.define do
  factory :user, traits: [:user]

  trait :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password "foobarfoobar"
    password_confirmation { |u| u.password }
  end
end
