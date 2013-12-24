require "spec_helper"

describe "Teacher home" do
  let(:teacher) { FactoryGirl.create(:teacher_with_courses) }
  before(:each) do
    login_as(teacher, as: :user)
    visit root_path
  end

  subject { page }

  it_should_behave_like "a user's homepage" do
    let(:user) { teacher }
  end
end
