FactoryGirl.define do
  factory :concept_progress do
    enrollment
    concept
    p_level { rand(1..4) }
    mastery_level { rand(1..4) }
    type_of_error { %w(Procedural Conceptual Misconception No\ Error).sample }
    next_steps { Faker::Lorem.sentence }

    factory :invalid_concept_progress do
      next_steps ""
    end
  end
end
