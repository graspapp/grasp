require "spec_helper"

describe Course do
  let(:course) { FactoryGirl.create(:course) }

  it { is_expected.to belong_to :teacher }
  it { is_expected.to have_many(:enrollments).dependent(:destroy) }
  it { is_expected.to have_many(:students).through(:enrollments) }
  it { is_expected.to have_many(:units).dependent(:destroy) }
  it { is_expected.to respond_to :name }
  it { is_expected.to respond_to :course_code }

  it { is_expected.to validate_uniqueness_of :course_code }

  context "with no teacher" do
    before { course.teacher = nil }
    it { is_expected.not_to be_valid }
  end

  context "with no name" do
    before { course.name = "" }
    it { is_expected.not_to be_valid }
  end

  context "with no course code" do
    before { course.course_code = "" }
    it { is_expected.not_to be_valid }
  end
end
