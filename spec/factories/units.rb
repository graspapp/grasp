FactoryGirl.define do
  factory :unit do
    course
    sequence(:number) { |n| "#{n}" }
    name { Faker::Lorem.sentence(1) }

    factory :invalid_unit do
      name ""
    end
  end
end
