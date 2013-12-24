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
end
