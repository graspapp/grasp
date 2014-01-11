FactoryGirl.define do
  factory :course do
    teacher
    name { Faker::Lorem.sentence(2) }

    factory :invalid_course do
      name ""
    end

    factory :course_with_units do
      ignore do
        units_count 5
      end

      after(:create) do |course, evaluator|
        create_list(:unit, evaluator.units_count, course: course)
      end
    end
  end
end
