class Unit < ActiveRecord::Base

  belongs_to :course
  has_many :learning_targets
end
