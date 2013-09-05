require 'spec_helper'

describe "Unit home" do

  before do
    
    teacher = add_course_and_unit(FactoryGirl.create(:teacher))
    @unit = teacher.courses.last.units.last
    @unit.learning_targets.create(number: "3.5", description: "2D Vectors")
    @learning_target = @unit.learning_targets.last

    visit unit_path(@unit)
  end

  subject { page }

  describe "persistent attributes" do

    it "should have the unit's name as the page title" do
      should have_title(@unit.name)
    end

    it "should include the unit's number and name in the heading" do
      should have_content("Unit #{ @unit.number } - #{ @unit.name }")
    end
  end


  describe "when logged in as a teacher" do
  end

  describe "when logged in as a student" do

    before do
      student = add_course_and_unit(FactoryGirl.create(:student))
      sign_in student
      visit unit_path(@unit)
    end

    it "should list learning target numbers" do
      should have_content(@learning_target.number)
    end

    it "should list learning target descriptions" do
      should have_content(@learning_target.description)
    end
  end
end

def add_course_and_unit(model)
  model.courses << FactoryGirl.create(:course)
  model.courses.last.units << FactoryGirl.create(:unit)
  model
end
