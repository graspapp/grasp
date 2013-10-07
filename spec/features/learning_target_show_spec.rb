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
      
      it "should not allow level changes without a comment" do
        click_link "Change Level"
        
        select  "2",        from: "level"

        click_link "Change Level"
        
        page.should have_css('div.fade') #modal form should remain active
        page.should have_content("You must leave a comment.") 
      end
      
      it "should allow level changes with a comment" do
        click_link "Change Level"
        fill_in "Comment",  with: "This is why I changed the level."
        select  "2",        from: "level"

        click_link "Change Level"
        
        page.should have_content("This is why I changed the level.") 
      end
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
