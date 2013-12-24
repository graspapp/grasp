FactoryGirl.define do
  factory :course do
    teacher
    sequence(:name) { |n| "Foo Bar #{ n }" }
  end
end
