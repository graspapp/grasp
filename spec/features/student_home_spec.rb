require 'spec_helper'

describe "Student home" do

  before do

    @student = FactoryGirl.create(:student, email: "student@email.com")
    sign_in @student
  end

  subject { page }

  describe "with no classes" do

    it "should have a button to add a new class" do

      if @student.courses.empty?
        should have_link "add one"
      end
    end

    describe "when adding a course" do

      before do

        @course = FactoryGirl.create(:course)
        @course_code = @course.code
      end

      describe "when no courses already exist" do

        it "should be able to add a course" do

          click_link "add one"

          fill_in "Course code", with: @course_code

          expect {
            click_button "Add Course"
          }.to change(@student.courses, :count).by(1)
        end
      end
    end
  end

  describe "with classes" do

    before do

      @course = FactoryGirl.create(:course)
      @student.courses << @course

      visit root_path
    end

    describe "when looking at a course overview" do

      it "should have the course's name" do

        should have_content(@course.name)
      end

      it "should have a button to create a new class" do

        should have_link('Add Course')
      end

      it "and no units exist" do

        @course.units.clear
        should have_content "Uh oh!"
      end

      describe "and units exist" do

        before do

          @course.units.create(name: "Test Unit", number: "1.31")
          @unit = @course.units.last
          visit root_path
        end

        it { should have_content @unit.name }
      end
    end
  end
end
