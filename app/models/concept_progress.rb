class ConceptProgress < ActiveRecord::Base
  after_initialize :set_defaults

  has_paper_trail

  belongs_to :enrollment
  belongs_to :concept

  validates_presence_of :type_of_error, :next_steps, :mastery_level, 
    :goal_level, :action_steps
  validates_length_of :action_steps, maximum: 140
  validates_inclusion_of :type_of_error, in: %w(N/A Procedural Conceptual
    Misconception Reasoning No\ Error)
  validates_inclusion_of :goal_level, in: 1..4
  validates_inclusion_of :mastery_level, in: 0..4
  validates_inclusion_of :completed, :in => [true, false]
  
  private

  def set_defaults
    not_available = "N/A"
    default_level = 1

    self.type_of_error ||= not_available
    self.next_steps ||= not_available
    self.mastery_level ||= default_level
    self.goal_level ||= default_level
    self.action_steps ||= not_available
    self.completed ||= false
  end
end
