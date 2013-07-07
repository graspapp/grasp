require 'spec_helper'

describe "Authentication" do
	
	subject { page }
  
  describe "teacher registration page" do
  
   before { visit teacher_sign_up_path }
   
   it { should have_selector('h2', text:'Sign up') }  
  end
  
  describe "teacher registration" do
    before { visit teacher_sign_up_path }
    
    describe "with invalid information" do
      it "should not create a new teacher" do
        expect { click_button "Create Account"}.not_to change(Teacher, :count)
      end
      
      describe "submission results" do
        before { click_button "Create Account" }
        it { should have_selector('h2', text:'Sign up') }
        it { should have_content('error') }
        it { should have_field('School') } #test for teacher specific field
      end
      
      describe "with valid information" do
        before do
          fill_in "First name",                   with: "Sample"
          fill_in "Last name",                    with: "Teacher"
          fill_in "Email",                        with: "teacher@school.org"
          fill_in "Password",                     with: "password"
          fill_in "Password confirmation",        with: "password"
          fill_in "School",                       with: "High School"
          fill_in "City",                         with: "Los Angeles"
          fill_in "State",                        with: "California"
          fill_in "Country",                      with: "USA"
        end
        
        it "should create a new teacher" do
          expect { click_button "Create Account" }.to change(Teacher, :count).by(1)
        end
      end
    end
  end
  
	describe "teacher sign in page" do

		before { visit teacher_sign_in_path }

		it { should have_selector('h2', text:'Sign in') }
	end

	describe "teacher sign in" do

		before { visit teacher_sign_in_path }

		describe "with invalid credentials" do

			before { click_button "Sign in" }

			it { should have_content "Invalid email or password." }
			
		end

		describe "with valid credentials" do

			before { sign_in_teacher(teacher) }

			let(:teacher) { FactoryGirl.create(:teacher) }

			it { should have_selector('h1', text:"#{ teacher.first_name } #{ teacher.last_name }") }
			it { should have_link('Sign Out', destroy_teacher_session_path) }
			it { should_not have_link('Sign In', sign_in_path) }
		end
	end
	
	
	describe "student registration page" do
  
   before { visit student_sign_up_path }
   
   it { should have_selector('h2', text:'Sign up') }  
  end
  
  describe "student registration" do
    before { visit student_sign_up_path }
    
    describe "with invalid information" do
      it "should not create a new student" do
        expect { click_button "Create Account"}.not_to change(Student, :count)
      end
      
      describe "submission results" do
        before { click_button "Create Account" }
        it { should have_selector('h2', text:'Sign up') }
        it { should have_content('error') }
        it { should have_field('Class code') } #test for student specific field
      end
      
      describe "with valid information" do
        before do
          fill_in "First name",                   with: "Sample"
          fill_in "Last name",                    with: "Student"
          fill_in "Email",                        with: "student@school.org"
          fill_in "Password",                     with: "password"
          fill_in "Password confirmation",        with: "password"
          fill_in "Class code",                   with: "2kj42lkj"
        end
        
        it "should create a new student" do
          expect { click_button "Create Account" }.to change(Student, :count).by(1)
        end
      end
    end
  end

	describe "student sign in page" do

		before { visit student_sign_in_path }

		it { should have_selector('h2', text:'Sign in') }
	end

	describe "student sign in" do

    before { visit student_sign_in_path }

    describe "with invalid credentials" do

      before { click_button "Sign in" }

      it { should have_content "Invalid email or password." }
    end

    describe "with valid credentials" do

      let(:student) { FactoryGirl.create(:student) }
      before { sign_in_student(student) }

      it {should have_selector('h1', text:"#{student.first_name} #{student.last_name}")}
      
    end
  end
end
