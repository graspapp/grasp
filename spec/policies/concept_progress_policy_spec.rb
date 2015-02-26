require "spec_helper"

describe ConceptProgressPolicy do
  subject { ConceptProgressPolicy.new(user, concept_progress) }

  let(:concept_progress) { FactoryGirl.create(:concept_progress) }

  context "not logged in" do
    let(:user) { nil }

    it { is_expected.not_to permit :edit }
    it { is_expected.not_to permit :update }
  end

  context "as a student" do
    let(:user) { FactoryGirl.create(:student) }

    it { is_expected.not_to permit :edit }
    it { is_expected.not_to permit :update }

    context "concept progress is part of a concept in the student's course" do
      before { user.courses << concept_progress.concept.unit.course }

      it { is_expected.to permit :edit }
      it { is_expected.to permit :update }
    end
  end

  context "as a teacher" do
    let(:user) { FactoryGirl.create(:teacher) }

    it { is_expected.not_to permit :edit }
    it { is_expected.not_to permit :update }

    context "when in an owned course" do
      before { user.courses << concept_progress.concept.unit.course }

      it { is_expected.to permit :edit }
      it { is_expected.to permit :update }
    end
  end
end
