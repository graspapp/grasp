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
    
    it "should display concepts in the right order" do
      @unit.concepts.create(number: "2a", description: "bar")
      @unit.concepts.create(number: "1a", description: "foo")
      visit current_path

      expect(page.text).to match(/.*1a.*2a/)
    end
  end


  describe "when logged in as a teacher" do

    before do
      sign_in @teacher
      visit unit_path(@unit)
    end

    it { should have_link "Edit Unit" }
    it { should have_link "Delete Unit" }
    
    describe "and no concepts exist" do

      before do
        @unit.concepts.delete_all
        visit unit_path(@unit)
      end

      it { should have_content("add a concept") }
    end

    describe "editing a unit" do

      context "with valid information" do
        before do
          click_link "Edit Unit"
          fill_in "Number", with: "2"
          fill_in "Name", with: "Logarithms"
          click_button "Save"

          @unit.reload
        end

        it { @unit.number.should eq "2" }
        it { @unit.name.should eq "Logarithms" }
        it { should have_selector("div.alert.alert-success") }
      end

      context "with invalid information" do
        before do
          click_link "Edit Unit"
          click_button "Save"
        end

        it { should have_selector("div.alert.alert-danger") }
      end
    end
    
    describe "unit deletion" do
      it "should delete the unit" do
        expect { click_link "Yes, Delete"}.to change(Unit, :count).by(-1)
      end
    end
  end

  describe "when logged in as a student" do

    before do
      @student = FactoryGirl.create(:student)
      @student.courses << @teacher.courses.last
      sign_in @student
      visit unit_path(@unit)

      @progress = concept_progress_for(@concept, @student)
    end

    it { should have_content(@concept.number) }
    it { should have_content(@concept.description) }
    it { should have_content(@progress.next_steps) }                         
    it { should have_content(@progress.p_level) }                         
    it { should_not have_link ("Delete Unit")}
    
    describe "when a concept progress doesn't exist" do

      before do
        @unit.concepts.first.concept_progresses.delete_all
        visit unit_path(@unit)
      end

      subject { @unit.concepts.first.concept_progresses }

      it { should_not be_empty }
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

def concept_progress_for(concept, student)
  course = concept.unit.course
  enrollment = Enrollment.where(student_id: student.id,
                                course_id: course.id).last

  ConceptProgress.where(enrollment_id: enrollment.id,
                        concept_id: concept.id).last
end

def add_course_and_unit(model)
  course = FactoryGirl.create(:course)
  unit = FactoryGirl.create(:unit)

  model.courses << course
  model.courses.last.units << unit
  model
end
