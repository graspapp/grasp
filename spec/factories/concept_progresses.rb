FactoryGirl.define do
  factory :concept_progress do
    enrollment
    concept
    p_level { rand(1..4) }
    mastery_level { rand(1..4) }
    type_of_error { Faker::Lorem.word.titleize }
    next_steps { Faker::Lorem.paragraph(3) }

    factory :invalid_concept_progress do
      next_steps ""
    end
  end
end
