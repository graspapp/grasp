require "spec_helper"

describe "Unit show" do
  let(:unit) { FactoryGirl.create(:unit) }
  before(:each) do
    user.courses << unit.course

    login_as(user, scope: :user)
    visit unit_path(unit)
  end

  subject { page }

  shared_examples_for "a unit show page" do
    it { should have_content unit.number }
    it { should have_content unit.name }
    it { should have_title unit.name }
  end

  context "as a teacher" do
    let(:user) { FactoryGirl.create(:teacher) }
    it_should_behave_like "a unit show page"
  end

  context "as a student" do
    let(:user) { FactoryGirl.create(:student) }
    it_should_behave_like "a unit show page"
  end
end
