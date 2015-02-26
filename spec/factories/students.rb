FactoryGirl.define do
  factory :student, traits: [:user] do
    factory :student_with_courses do
      transient do
        courses_count 5
      end

      after(:create) do |student, evaluator|
        evaluator.courses_count.times do
          student.courses << FactoryGirl.create(:course)
        end
      end
    end

    factory :invalid_student do
      first_name nil
    end
  end
end
