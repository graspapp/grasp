FactoryGirl.define do
  factory :concept_progress do
    enrollment
    concept
    goal_level { rand(1..4) }
    mastery_level { rand(0..4) }
    type_of_error { %w(Procedural Conceptual Misconception No\ Error).sample }
    action_steps { Faker::Lorem.sentence }

    factory :invalid_concept_progress do
      goal_level { rand(1..4) }
      action_steps ""
    end
  end
end
