class ConceptProgress < ActiveRecord::Base

  has_paper_trail

  after_initialize :init

  belongs_to :enrollment
  belongs_to :concept
  has_many :comments
  
  validates_presence_of :level, :type_of_error, :next_steps

  def init
    not_available = "N/A"

    self.level ||= 1
    self.type_of_error = not_available
    self.next_steps = not_available
  end
  
  def change_level(lev)
    self.level = lev
  end
  
  def add_comment(com)
    self.comments << com
  end
end
