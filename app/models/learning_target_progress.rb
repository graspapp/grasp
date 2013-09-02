class LearningTargetProgress < ActiveRecord::Base

  belongs_to :enrollment
  has_paper_trail
  
  validates_presence_of :learning_target_id, :level
end
