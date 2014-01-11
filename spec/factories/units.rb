FactoryGirl.define do
  factory :unit do
    course
    sequence(:number) { |n| "#{n}" }
    name { Faker::Lorem.sentence(1) }

    factory :invalid_unit do
      name ""
    end

    factory :unit_with_concepts do
      ignore do
        concepts_count 5
      end

      after(:create) do |unit, evaluator|
        create_list(:concept, evaluator.concepts_count, unit: unit)
      end
    end
  end
end
