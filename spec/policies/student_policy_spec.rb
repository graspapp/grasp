require "spec_helper"

describe StudentPolicy do
  subject { StudentPolicy.new(student, user) }

  let(:student) { FactoryGirl.create(:student) }

  context "when modifying self" do
    let(:user) { student }
    it { should permit(:add_course) }
    it { should permit(:leave_course) }
  end

  context "when modifying someone else" do
    let(:user) { FactoryGirl.create(:student) }
    it { should_not permit(:add_course) }
    it { should_not permit(:leave_course) }
  end
end
