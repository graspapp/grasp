FactoryGirl.define do

	factory :student do
		first_name				    "Facory"
		last_name				      "Student"
		email					        "factstud@sample.com"
		password  				    "samplepassword"
		password_confirmation	"samplepassword"
		class_code				    "13dsja34"
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

    factory :teacher_with_course do
      after_create do |course|
        create(:course, teacher: teacher)
      end
    end
	end

  factory :course do
    name "Algebra 2AB"
  end
end
