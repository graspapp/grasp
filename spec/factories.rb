FactoryGirl.define do

  factory :student do
    first_name                      'Factory'
    last_name                       'Student'
    email                           'factstud@sample.com'
    password                        'samplepassword'
    password_confirmation           'samplepassword'
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
  
  factory :concept do
    number      "1.1a"
    description "Ability to graph the sine function without a calculator."
  end
  
  factory :enrollment do
    course_id 1
    student_id 1
  end
  
  factory :task do
    status            "Incomplete"
    content           "Do something."
    concept 
  end

  factory :concept_progress do
    concept_id    1
    enrollment_id 1
    # We have the crazy numbers here to differentiate between P and G levels.
    #
    # TODO: Figure out a better way to do this, especially once we implement
    # serverside validation for these values.
    p_level 3242
    g_level 23094
  end
end

