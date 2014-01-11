FactoryGirl.define do
  factory :contact do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    subject { Faker::Lorem.words.join(" ") }
    message { Faker::Lorem::paragraphs.join(" ") }
  end
end
