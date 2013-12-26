FactoryGirl.define do
  factory :course do
    teacher
    name { Faker::Lorem.sentence(2) }
  end
end
