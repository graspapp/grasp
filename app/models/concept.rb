class Concept < ActiveRecord::Base

  belongs_to :unit
  has_many :concept_progresses, dependent: :destroy
  has_many :tasks, dependent: :destroy

  validates_presence_of :description, :number
end
