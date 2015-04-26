require "spec_helper"

describe CoursePolicy do
  subject { CoursePolicy.new(user, course) }

  let(:course) { FactoryGirl.create(:course) }

  context "logged in as teacher" do
    let(:user) { FactoryGirl.create(:teacher) }

    context "and owns course" do
      before { user.courses << course }

      it { is_expected.to permit(:show) }
      it { is_expected.to permit(:create) }
      it { is_expected.to permit(:edit) }
      it { is_expected.to permit(:update) }
      it { is_expected.to permit(:destroy) }
    end

    context "and doesn't own course" do
      it { is_expected.not_to permit(:show) }
      it { is_expected.not_to permit(:create) }
      it { is_expected.not_to permit(:edit) }
      it { is_expected.not_to permit(:update) }
      it { is_expected.not_to permit(:destroy) }
    end
  end

  context "logged in as student" do
    let(:user) { FactoryGirl.create(:student) }

    it { is_expected.not_to permit(:show) }
    it { is_expected.not_to permit(:create) }
    it { is_expected.not_to permit(:edit) }
    it { is_expected.not_to permit(:update) }
    it { is_expected.not_to permit(:destroy) }

    context "and is in course" do
      before { user.courses << course }

      it { is_expected.to permit(:show) }
    end
  end

  context "not logged in" do
    let(:user) { nil }

    it { is_expected.not_to permit(:show) }
    it { is_expected.not_to permit(:create) }
    it { is_expected.not_to permit(:edit) }
    it { is_expected.not_to permit(:update) }
    it { is_expected.not_to permit(:destroy) }
  end
end
