FactoryGirl.define do
  factory :concept do
    unit
    sequence(:number) { |n| "#{n}" }
    description { Faker::Lorem.sentence(5) }

    factory :invalid_concept do
      description ""
    end
  end
end
