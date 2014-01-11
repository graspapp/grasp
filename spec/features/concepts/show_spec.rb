require "spec_helper"

describe "Concept show" do
  let(:concept) { FactoryGirl.create(:concept) }
  before(:each) do
    user.courses << concept.unit.course

    login_as(user, scope: :user)
    visit concept_path(concept)
  end

  subject { page }

  shared_examples_for "a concept show page" do
    it { should have_content concept.number }
    it { should have_title "Concept #{ concept.number }" }

    # TODO: Test showing of concept progress attributes
  end

  context "as a teacher" do
    let(:user) { FactoryGirl.create(:teacher) }

    it_should_behave_like "a concept show page"

    # TODO: Test editing student concept progresses
  end

  context "as a student" do
    let(:user) { FactoryGirl.create(:student) }

    it_should_behave_like "a concept show page"

    # TODO: Test editing concept progress
  end
end
