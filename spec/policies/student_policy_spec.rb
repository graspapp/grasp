require "spec_helper"

describe StudentPolicy do
  subject { StudentPolicy.new(student, user) }

  let(:student) { FactoryGirl.create(:student) }

  context "when modifying self" do
    let(:user) { student }
    it { is_expected.to permit(:add_course) }
    it { is_expected.to permit(:leave_course) }
  end

  context "when modifying someone else" do
    let(:user) { FactoryGirl.create(:student) }
    it { is_expected.not_to permit(:add_course) }
    it { is_expected.not_to permit(:leave_course) }
  end
end
