FactoryGirl.define do
  factory :user, traits: [:user]

  trait :user do
    first_name "Foo"
    last_name "Bar"
    sequence(:email) { |n| "foo#{ n }@bar.com" }
    password "foobarfoobar"
    password_confirmation { |u| u.password }
  end
end
