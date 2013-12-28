require "spec_helper"

describe CoursePolicy do
  subject { CoursePolicy.new(user, course) }

  let(:course) { FactoryGirl.create(:course) }

  context "logged in as teacher" do
    let(:user) { FactoryGirl.create(:teacher) }

    it { should permit(:new) }
    
    context "and owns course" do
      before { user.courses << course }

      it { should permit(:show) }
      it { should permit(:create) }
      it { should permit(:edit) }
      it { should permit(:update) }
      it { should permit(:destroy) }
    end

    context "and doesn't own course" do
      it { should_not permit(:show) }
      it { should_not permit(:create) }
      it { should_not permit(:edit) }
      it { should_not permit(:update) }
      it { should_not permit(:destroy) }
    end
  end

  context "logged in as student" do
    let(:user) { FactoryGirl.create(:student) }

    it { should_not permit(:new) }
    it { should_not permit(:show) }
    it { should_not permit(:create) }
    it { should_not permit(:edit) }
    it { should_not permit(:update) }
    it { should_not permit(:destroy) }

    context "and is in course" do
      before { user.courses << course }

      it { should permit(:show) }
    end
  end

  context "not logged in" do
    let(:user) { nil }

    it { should_not permit(:new) }
    it { should_not permit(:show) }
    it { should_not permit(:create) }
    it { should_not permit(:edit) }
    it { should_not permit(:update) }
    it { should_not permit(:destroy) }
  end
end
