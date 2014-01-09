require "spec_helper"

describe ConceptProgressPolicy do
  subject { ConceptProgressPolicy.new(user, concept_progress) }

  let(:concept_progress) { FactoryGirl.create(:concept_progress) }

  context "not logged in" do
    let(:user) { nil }

    it { should_not permit :edit }
    it { should_not permit :update }
  end

  context "as a student" do
    let(:user) { FactoryGirl.create(:student) }

    it { should_not permit :edit }
    it { should_not permit :update }

    context "concept progress is part of a concept in the student's course" do
      before { user.courses << concept_progress.concept.unit.course }

      it { should permit :edit }
      it { should_not permit :update }
    end
  end

  context "as a teacher" do
    let(:user) { FactoryGirl.create(:teacher) }

    it { should_not permit :edit }
    it { should_not permit :update }

    context "when in an owned course" do
      before { user.courses << concept_progress.concept.unit.course }

      it { should permit :edit }
      it { should permit :update }
    end
  end
end
