class ConceptProgress < ActiveRecord::Base
  belongs_to :enrollment
  belongs_to :concept

  validates_presence_of :type_of_error, :next_steps, :g_level, :p_level
end
