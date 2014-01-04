require "spec_helper"

describe ConceptPolicy do
  subject { ConceptPolicy.new(user, concept) }

  let(:concept) { FactoryGirl.create(:concept) }

  context "not logged in" do
    let(:user) { nil }

    it { should_not permit :show }
    it { should_not permit :create }
    it { should_not permit :edit }
    it { should_not permit :update }
    it { should_not permit :destroy }
  end

  context "as a student" do
    let(:user) { FactoryGirl.create(:student) }

    it { should_not permit :show }
    it { should_not permit :create }
    it { should_not permit :edit }
    it { should_not permit :update }
    it { should_not permit :destroy }

    context "when course is part of a unit in the student's course" do
      before { user.courses << concept.unit.course }

      it { should permit :show }
      it { should_not permit :create }
      it { should_not permit :edit }
      it { should_not permit :update }
      it { should_not permit :destroy }
    end
  end

  context "as a teacher" do
    let(:user) { FactoryGirl.create(:teacher) }

    it { should_not permit :show }
    it { should_not permit :create }
    it { should_not permit :edit }
    it { should_not permit :update }
    it { should_not permit :destroy }

    context "when in an owned course" do
      before { user.courses << concept.unit.course }

      it { should permit :show }
      it { should permit :create }
      it { should permit :edit }
      it { should permit :update }
      it { should permit :destroy }
    end
  end
end
