FactoryGirl.define do
  factory :concept do
    unit
    sequence(:name) { |n| "#{n}" }
    description { Faker::Lorem.sentence(5) }
    dok1_resources { Faker::Lorem.sentence(5) }
    dok2_resources { Faker::Lorem.sentence(5) }
    dok3_resources { Faker::Lorem.sentence(5) }

    factory :invalid_concept do
      description ""
    end

    factory :concept_with_concept_progresses do
      transient do
        concept_progresses_count 5
      end

      after(:create) do |concept, evaluator|
        create_list(:concept_progress, evaluator.concept_progresses_count,
                    concept: concept)
      end
    end
  end
end
