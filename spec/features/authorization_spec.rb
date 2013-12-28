require "spec_helper"

describe "Authorization" do
  subject { page }

  describe "accessing an unauthorized resource" do
    let(:course) { FactoryGirl.create(:course) }
    before { visit course_path(course) }

    it { should have_content "not authorized" }
  end

  describe "accessing an authorized resource" do
    let(:teacher) { FactoryGirl.create(:teacher_with_courses) }
    let(:course) { teacher.courses.first }
    before do
      login_as(teacher, scope: :user)
      visit course_path(course)
    end

    it { should have_content course.name }
    it { should_not have_content "not authorized" }
  end
end
