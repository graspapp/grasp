require "spec_helper"

describe UnitPolicy do
  subject { UnitPolicy.new(user, unit) }

  let(:unit) { FactoryGirl.create(:unit) }

  context "not logged in" do
    let(:user) { nil }

    it { is_expected.not_to permit :show }
    it { is_expected.not_to permit :create }
    it { is_expected.not_to permit :edit }
    it { is_expected.not_to permit :update }
    it { is_expected.not_to permit :destroy }
  end

  context "as a student" do
    let(:user) { FactoryGirl.create(:student) }

    it { is_expected.not_to permit :show }
    it { is_expected.not_to permit :create }
    it { is_expected.not_to permit :edit }
    it { is_expected.not_to permit :update }
    it { is_expected.not_to permit :destroy }

    context "when unit is in course student is in" do
      before { user.courses << unit.course }

      it { is_expected.to permit :show }
      it { is_expected.not_to permit :create }
      it { is_expected.not_to permit :edit }
      it { is_expected.not_to permit :update }
      it { is_expected.not_to permit :destroy }
    end
  end

  context "as a teacher" do
    let(:user) { FactoryGirl.create(:teacher) }

    it { is_expected.not_to permit :show }
    it { is_expected.not_to permit :create }
    it { is_expected.not_to permit :edit }
    it { is_expected.not_to permit :update }
    it { is_expected.not_to permit :destroy }

    context "when in an owned course" do
      before { user.courses << unit.course }

      it { is_expected.to permit :show }
      it { is_expected.to permit :create }
      it { is_expected.to permit :edit }
      it { is_expected.to permit :update }
      it { is_expected.to permit :destroy }
    end
  end
end
