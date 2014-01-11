require "spec_helper"

describe Enrollment do
  it { should belong_to :student }
  it { should belong_to :course }

  it { should have_many(:concept_progresses).dependent(:destroy) }

  it { should validate_presence_of :student }
  it { should validate_presence_of :course }
  it { should validate_uniqueness_of(:course_id).scoped_to(:student_id) }
  it { should validate_uniqueness_of(:student_id).scoped_to(:course_id) }
end
