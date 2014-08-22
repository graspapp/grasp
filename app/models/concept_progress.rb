class ConceptProgress < ActiveRecord::Base
  after_initialize :set_defaults

  has_paper_trail

  belongs_to :enrollment
  belongs_to :concept
  
  scope :sorted, lambda{
    joins(:enrollment).joins(:enrollment => :student)
    .order('last_name ASC, first_name ASC')
  }

  validates_presence_of :type_of_error, :next_steps, :mastery_level, 
    :goal_level, :action_steps, :effort, :note_taking, :studying
  validates_length_of :action_steps, maximum: 140
  validates_inclusion_of :type_of_error, in: %w(N/A Procedural Conceptual
    Misconception Reasoning No\ Error)
  validates_inclusion_of :goal_level, in: 1..4
  validates_inclusion_of :mastery_level, in: -1..4
  validates_inclusion_of :effort, in: 1..4
  validates_inclusion_of :note_taking, in: 1..4
  validates_inclusion_of :studying, in: 1..4
  
  def chart_data()
    updates = self.versions.last(5)  
    if updates.length < 2
      data = [
        date: self.created_at.localtime.strftime("%m/%d/%Y %I:%M %p"),
        goal: self.goal_level,
        mastery: self.mastery_level,
        effort: self.effort,
        next_step: self.next_steps
      ]
    else
      updates.shift
      
      data = updates.map do |u|
        {
          date: u.reify.updated_at.localtime.strftime("%m/%d/%Y %I:%M %p"),
          goal: u.reify.goal_level,
          mastery: u.reify.mastery_level,
          effort: u.reify.effort,
          next_step: u.reify.next_steps
        }
      end

      # append live version of the record
      # paper trail does not track it
      data.push(
        date: self.updated_at.localtime.strftime("%m/%d/%Y %I:%M %p"),
        goal: self.goal_level,
        mastery: self.mastery_level,
        effort: self.effort,
        next_step: self.next_steps
        )
    end
  end

  private

  def set_defaults
    not_available = "N/A"
    incomplete = "Incomplete"
    see_teacher = "See Teacher"
    default_level = 1

    self.type_of_error ||= not_available
    self.next_steps ||= not_available
    self.mastery_level ||= 0
    self.goal_level ||= default_level
    self.effort ||= default_level
    self.note_taking ||= default_level
    self.studying ||= default_level
    self.action_steps ||= not_available
  end
end
