require "spec_helper"

describe "Student home" do
  let(:student) { FactoryGirl.create(:student_with_courses) }
  before(:each) do
    login_as(student, scope: :user)
    visit root_path
  end

  subject { page }

  it_should_behave_like "a user's homepage" do
    let(:user) { student }
  end

  describe "adding a course" do
    let(:course) { FactoryGirl.create(:course) }
    before do
      click_link "Add Course"

      fill_in "Course code", with: course.course_code
      click_button "Add Course"
    end

    it { is_expected.to have_content course.name }
    it { is_expected.to have_content course.course_code }
  end
end
