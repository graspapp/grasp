FactoryGirl.define do
  factory :unit do
    course
    sequence(:number) { |n| "#{n}" }
    name { Faker::Lorem.sentence(1) }
  end
end
