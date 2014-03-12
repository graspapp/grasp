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
      it { should have_link("Edit") }
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
          click_link "Edit"

          page.find_by_id("concept_progress_goal_level").
                    find("option[value='#{concept_progress.goal_level}']").
                    select_option
          
          page.find_by_id("concept_progress_mastery_level").
                    find("option[value='#{concept_progress.mastery_level}']").
                    select_option
          
          # Commented out until db is updated
          
          # page.find_by_id("concept_progress_type_of_error").
                    # find("option[value='#{concept_progress.type_of_error}']").
                    # select_option
          # page.find_by_id("concept_progress_next_steps").
                    # find("option[value='Play in Brilliant.org']").select_option                      
          fill_in("Timeline to accomplish next steps", 
          :with => concept_progress[:action_steps])
          check("Completed?")
          check("Leveling Up?")
        end
        
        context "with valid attributes" do
          before { click_button "Edit Concept Progress" }
          it { should have_selector("td", concept_progress[:goal_level]) }
          it { should have_selector("td", concept_progress[:mastery_level]) }
          it { should have_selector("td", concept_progress[:type_of_error]) }
          it { should have_selector("td", concept_progress[:completed]) }
          it { should have_selector("td", concept_progress[:leveling_up]) }
        end
        
        context "with invalid attributes" do
             
          before do
            fill_in("Timeline to accomplish next steps", with: "")
            click_button "Edit Concept Progress"
          end       
          
          it { should have_content "can't be blank" }
        end
      end
    end
  end
end