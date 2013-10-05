require 'spec_helper'

describe "LearningTarget detail view" do

  before { @lt = FactoryGirl.create(:concept) }

  subject { page }

  describe "when logged in as a teacher" do

    before do

      @teacher = add_concept(FactoryGirl.create(:teacher), @lt)
      sign_in @teacher
      visit concept_path(@lt)
    end

    it { should have_content(@lt.number) }
    
    describe "when teacher has no students" do
      
      it { should have_content "There are currently no students enrolled." }
    end  
    
    describe "when teacher has students" do
      
      before do
        
        @student = add_concept(FactoryGirl.create(:student), @lt)
        @student = add_lt_progress(@student)
        visit concept_path(@lt)
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

      @student = add_concept(FactoryGirl.create(:student), @lt)
      sign_in @student
      visit concept_path(@lt)
    end

    it { should have_content(@lt.number) }
  end
end

def add_concept(model, lt)
  model.courses << FactoryGirl.create(:course)
  model.courses.last.units << FactoryGirl.create(:unit)
  model.courses.last.units.last.concepts << lt
  model
end

def add_lt_progress(model)
  model.courses.last.units.last.concepts.last.
    learning_target_progresses << FactoryGirl.create(:learning_target_progress)
  model
end
