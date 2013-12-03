class ConceptProgress < ActiveRecord::Base

  has_paper_trail

  after_initialize :init

  belongs_to :enrollment
  belongs_to :concept
  
  validates_presence_of :type_of_error, :next_steps, :p_level, :g_level

  def init
    not_available = "N/A"
    default_level = 1

    self.type_of_error ||= not_available
    self.next_steps ||= not_available
    self.g_level ||= default_level
    self.p_level ||= default_level
  end
end
