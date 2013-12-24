require "spec_helper"

describe Course do
  let(:course) { FactoryGirl.create(:course) }

  describe "attributes" do
    it { should belong_to :teacher }
    it { should have_many(:students).through(:enrollments) }
    it { should respond_to :name }
    it { should respond_to :course_code }
  end

  context "no teacher" do
    before { course.teacher = nil }
    it { should_not be_valid }
  end

  context "no name" do
    before { course.name = "" }
    it { should_not be_valid }
  end

  context "no course code" do
    before { course.course_code = "" }
    it { should_not be_valid }
  end
end
