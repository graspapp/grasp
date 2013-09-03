class LearningTargetProgress < ActiveRecord::Base

  has_paper_trail
  belongs_to :enrollment
  
  validates_presence_of :learning_target_id, :level
end
