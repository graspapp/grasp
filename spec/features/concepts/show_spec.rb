require "spec_helper"

describe "Concept show" do
  let(:concept) { FactoryGirl.create(:concept_with_concept_progresses,
    concept_progresses_count: 1) }
  before(:each) do
    user.courses << concept.unit.course

    login_as(user, scope: :user)
    visit concept_path(concept)  
  end

  subject { page }

  shared_examples_for "a concept show page" do
    it { should have_content concept.name }
    it { should have_title "Concept #{ concept.name }" }

    describe "concept progress attributes" do
      let(:concept_progress) { concept.concept_progresses.first }
      it { should have_link("Update Levels") }
    end
  end

  context "as a teacher" do
    let(:user) { FactoryGirl.create(:teacher) }
    
    # it_should_behave_like "a concept show page"

    # TODO: Test editing teacher concept progresses
  end

  context "as a student" do
    let(:user) { FactoryGirl.create(:student) }
    let(:concept_progress) { concept.concept_progresses.first }
    
    it_should_behave_like "a concept show page"

    describe "actions" do
      describe "editing concept progress" do
        before do
          click_link "Update Levels"
          # page.find_by_id("concept_progress_goal_level").
                    # find("option[value='#{concept_progress.goal_level}']").
                    # select_option
          
          # page.find_by_id("concept_progress_mastery_level").
                    # find("option[value='#{concept_progress.mastery_level}']").
                    # select_option
                              
        end
        
        context "with valid attributes" do
          before { click_button "Update Your Progress" }
          it { should have_selector("td", concept_progress[:goal_level]) }
          it { should have_selector("td", concept_progress[:mastery_level]) }
        end      
      end
    end
  end
end