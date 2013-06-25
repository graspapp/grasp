FactoryGirl.define do
	factory :user do
		first_name				"John"
		last_name				"Doe"
		email					"johndoe@example.com"
		password				"jdoepass"
		password_confirmation	"jdoepass"
	end

	factory :teacher do
		school					"Sample School"
		state					"CA"
		country					"USA"
		user
	end

	factory :student do
		user
	end
end