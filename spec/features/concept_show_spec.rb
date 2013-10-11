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
    end

    it { should have_content(@concept.number) }
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
