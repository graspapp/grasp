class Enrollment < ActiveRecord::Base
  belongs_to :student
  belongs_to :course

  has_many :concept_progresses, dependent: :destroy

  validates_presence_of :student, :course
end
