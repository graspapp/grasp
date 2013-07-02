require 'spec_helper'

describe "Authentication" do
	
	subject {page}

	describe "teacher sign in page" do
		before { visit teacher_sign_in_path }

		it {should have_selector('h2', text:'Sign in')}
	end

	describe "teacher sign in" do
		before { visit teacher_sign_in_path }

		describe "with invalid credentials" do
			before {click_button "Sign in"}
			it {should have_content "Invalid email or password."}
		end

		describe "with valid credentials" do
			let(:teacher){FactoryGirl.create(:teacher)}
			before {sign_in_teacher(teacher)}

			it {should have_selector('h1', text:"#{teacher.first_name} #{teacher.last_name}")}
			it {should have_link('Sign Out', destroy_teacher_session_path)}
			it {should_not have_link('Sign In', sign_in_path)}
		end
	end

	describe "student sign in page" do
		before { visit student_sign_in_path }

		it {should have_selector('h2', text:'Sign in')}
	end

	describe "student sign in" do
	before { visit student_sign_in_path }

	describe "with invalid credentials" do
		before {click_button "Sign in"}
		it {should have_content "Invalid email or password."}
	end

	describe "with valid credentials" do
		let(:student){FactoryGirl.create(:student)}
		before {sign_in_student(student)}

		it {should have_selector('h1', text:"#{student.first_name} #{student.last_name}")}
	end
end

end