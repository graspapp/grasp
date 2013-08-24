FactoryGirl.define do

  factory :student do
    first_name                      'Factory'
    last_name                       'Student'
    email                           'factstud@sample.com'
    password                        'samplepassword'
    password_confirmation           'samplepassword'
    class_code                      '13dsja34'
  end

	factory :teacher do
    first_name            "Factory"
    last_name             "Teacher"
    email                 "factteach@sample.com"
    password  				    "samplepassword"
    password_confirmation "samplepassword"
    school                "Sample School"
    city                  "LA"
    state                 "CA"
    country               "USA"
	end

  factory :course do
    name "Algebra"
  end

  factory :unit do
    name   "Trigonometry"
    number "1.2"
  end
  
  factory :learning_target do
    number      "1"
    description "I can solve..."
  end
  
  factory :task do
    status            "Incomplete"
    content           "Do something."
    learning_target
  end
end

