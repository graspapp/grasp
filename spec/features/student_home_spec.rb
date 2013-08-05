require 'spec_helper'

describe "Student home" do

  before do

    visit student_sign_up_path
    
    @student = FactoryGirl.build(:student, email: "student@email.com")

    fill_in "Full name",             with: @student.full_name
    fill_in "Email",                 with: @student.email
    fill_in "Password",              with: @student.password
    fill_in "Password confirmation", with: @student.password_confirmation
    fill_in "Class code",            with: @student.class_code
    click_button "Create Account"

    visit root_path
  end

  subject { page }

  describe "with no classes" do

    it "should have a button to add a new class" do

      if @student.courses.empty?
        should have_link "add one"
      end
    end
  end
end
