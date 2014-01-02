require "spec_helper"

describe "Course show" do
  let(:course) { FactoryGirl.create(:course) }
  before(:each) do
    user.courses << course

    login_as(user, scope: :user)
    visit course_path(course)
  end

  context "as a teacher" do
    let(:user) { FactoryGirl.create(:teacher) }

    it { should_not have_button "Leave Course" }
  end

  context "as a student" do
    let(:user) { FactoryGirl.create(:student) }

    it "should leave course" do
      expect {
        click_button "Leave Course"
      }.to change(user.courses, :count).by -1
    end
  end
end
