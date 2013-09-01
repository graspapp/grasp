class Enrollment < ActiveRecord::Base

  belongs_to :student
  belongs_to :course
  has_many :learning_target_progresses
end
