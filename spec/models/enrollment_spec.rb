require "spec_helper"

describe Enrollment do
  it { is_expected.to belong_to :student }
  it { is_expected.to belong_to :course }

  it { is_expected.to have_many(:concept_progresses).dependent(:destroy) }

  it { is_expected.to validate_presence_of :student }
  it { is_expected.to validate_presence_of :course }
  it { is_expected.to validate_uniqueness_of(:course_id).scoped_to(:student_id) }
  it { is_expected.to validate_uniqueness_of(:student_id).scoped_to(:course_id) }
end
