require 'spec_helper'

describe "Concept detail view" do

  before { @concept = FactoryGirl.create(:concept) }

  subject { page }

  describe "when logged in as a teacher" do

    before do

      @teacher = add_concept(FactoryGirl.create(:teacher), @concept)
      sign_in @teacher
      visit concept_path(@concept)
    end

    it { should have_content(@concept.number) }
    
    describe "when teacher has no students" do
      
      it { should have_content "There are currently no students enrolled." }
    end  
    
    describe "when teacher has students" do
      
      before do
        
        @student = add_concept(FactoryGirl.create(:student), @concept)
        @student = add_concept_progress(@student)
        visit concept_path(@concept)
      end
      
      it { should have_content @student.full_name }      
    end
  end

  describe "when logged in as a student" do

    before do

      @student = add_concept(FactoryGirl.create(:student), @concept)
      sign_in @student
      visit concept_path(@concept)

      @progress = concept_progress_for(@concept, @student)

      # We need to set these to crazy values to differentiate from the current
      # level.
      #
      # TODO: Find a better way to do this, especially once we implemenet
      # serverside validation for these values.
      @progress.g_level = 2230948
      @progress.p_level = 2324920394
      @progress.save

      visit concept_path(@concept)
    end

    it { should have_content(@concept.number) }
    it { should have_content(@progress.created_at.to_formatted_s(:mdy)) }
    it { should have_content(@progress.g_level) }
    it { should have_content(@progress.type_of_error) }
    it { should have_content(@progress.next_steps) }
    it { should have_content(@progress.p_level) }

    describe  "modifying concept progress", js: true do
      before do
        click_link "Edit Concept"
        select "Procedural", from: "type_of_error" 
        select "Create a model card.", from: "next_steps"
        select "2", from: "p_level"
        select "3", from: "g_level"
        click_button "Save"

        @progress.reload
      end

      it { @progress.type_of_error.should eq "Procedural" }
      it { @progress.next_steps.should eq "Create a model card." }
      it { @progress.p_level.should eq 2 }
      it { @progress.g_level.should eq 3 }
    end
  end
end

def add_concept(model, concept)
  model.courses << FactoryGirl.create(:course)
  model.courses.last.units << FactoryGirl.create(:unit)
  model.courses.last.units.last.concepts << concept
  model
end

def add_concept_progress(model)
  model.courses.last.units.last.concepts.last.
    concept_progresses << FactoryGirl.create(:concept_progress)
  model
end

def concept_progress_for(concept, student)
  course = concept.unit.course
  enrollment = Enrollment.where(student_id: student.id,
                                course_id: course.id).last

  ConceptProgress.where(enrollment_id: enrollment.id,
                        concept_id: concept.id).last
end
