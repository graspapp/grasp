FactoryGirl.define do
  factory :course do
    teacher
    name { Faker::Lorem.sentence(2) }

    factory :invalid_course do
      name ""
    end
  end
end
