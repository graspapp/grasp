require "spec_helper"

describe "Concept Progress show" do
  let(:concept) { FactoryGirl.create(:concept_with_concept_progresses,
    concept_progresses_count: 1) }
  before(:each) do
    user.courses << concept.unit.course

    login_as(user, scope: :user)
    visit concept_progress_path(concept.concept_progresses.first)  
  end

  subject { page }

  context "as a teacher" do
    let(:user) { FactoryGirl.create(:teacher) }

    # Ensure the graph's div is rendered
    it { should have_css("div#cp_chart")}
  end
end