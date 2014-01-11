class Enrollment < ActiveRecord::Base
  belongs_to :student
  belongs_to :course

  has_many :concept_progresses, dependent: :destroy

  validates_presence_of :student, :course
  validates_uniqueness_of :course_id, scope: :student
  validates_uniqueness_of :student_id, scope: :course
end
