class ConceptProgress < ActiveRecord::Base
  after_initialize :set_defaults

  belongs_to :enrollment
  belongs_to :concept

  validates_presence_of :type_of_error, :next_steps, :mastery_level, :p_level

  private

  def set_defaults
    not_available = "N/A"
    default_level = 1

    self.type_of_error ||= not_available
    self.next_steps ||= not_available
    self.mastery_level ||= default_level
    self.p_level ||= default_level
  end
end
