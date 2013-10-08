require 'spec_helper'

describe "Unit home" do

  before do
    
    @teacher = add_course_and_unit(FactoryGirl.create(:teacher))
    @unit = @teacher.courses.last.units.last
    @unit.concepts.create(number: "3.5", description: "2D Vectors")
    @concept = @unit.concepts.last

  end

  subject { page }

  describe "persistent attributes" do

    before do
      
      sign_in @teacher
      visit unit_path(@unit)
    end
    
    it "should have the unit's name as the page title" do
      should have_title(@unit.name)
    end

    it "should include the unit's number and name in the heading" do
      should have_content("Unit #{ @unit.number } - #{ @unit.name }")
    end
  end


  describe "when logged in as a teacher" do

    before do
      sign_in @teacher
      visit unit_path(@unit)
    end

    describe "and no concepts exist" do

      before do
        @unit.concepts.delete_all
        visit unit_path(@unit)
      end

      it { should have_content("add a concept") }
    end
  end

  describe "when logged in as a student" do

    before do
      student = add_course_and_unit(FactoryGirl.create(:student))
      sign_in student
      visit unit_path(@unit)
    end

    it "should list concept numbers" do
      should have_content(@concept.number)
    end

    it "should list concept descriptions" do
      should have_content(@concept.description)
    end

    describe "and no concepts exist" do

      before do
        @unit.concepts.delete_all
        visit unit_path(@unit)
      end

      it { should have_content("Uh oh") }
    end
  end
end

def add_course_and_unit(model)
  model.courses << FactoryGirl.create(:course)
  model.courses.last.units << FactoryGirl.create(:unit)
  model
end
