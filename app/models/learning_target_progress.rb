class LearningTargetProgress < ActiveRecord::Base

  belongs_to :enrollment
  
  validates_presence_of :learning_target_id, :level
end
