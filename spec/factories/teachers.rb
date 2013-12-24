FactoryGirl.define do
  factory :teacher, traits: [:user] do
    factory :teacher_with_courses do
      ignore do
        courses_count 5
      end

      after(:create) do |teacher, evaluator|
        create_list(:course, evaluator.courses_count, teacher: teacher)
      end
    end
  end
end
