require "spec_helper"

describe Course do
  let(:course) { FactoryGirl.create(:course) }

  it { should belong_to :teacher }
  it { should have_many(:enrollments).dependent(:destroy) }
  it { should have_many(:students).through(:enrollments) }
  it { should have_many(:units).dependent(:destroy) }
  it { should respond_to :name }
  it { should respond_to :course_code }

  it { should validate_uniqueness_of :course_code }

  context "with no teacher" do
    before { course.teacher = nil }
    it { should_not be_valid }
  end

  context "with no name" do
    before { course.name = "" }
    it { should_not be_valid }
  end

  context "with no course code" do
    before { course.course_code = "" }
    it { should_not be_valid }
  end
end
