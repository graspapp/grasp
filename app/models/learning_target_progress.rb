class LearningTargetProgress < ActiveRecord::Base

  has_paper_trail

  after_initialize :init

  belongs_to :enrollment
  belongs_to :concept
  has_many :comments
  
  validates_presence_of :level

  def init
    self.level ||= 1
  end
  
  def change_level(lev)
    self.level = lev
  end
  
  def add_comment(com)
    self.comments << com
  end
end
