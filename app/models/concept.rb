class Concept < ActiveRecord::Base
  belongs_to :unit

  has_many :concept_progresses, dependent: :destroy

  validates_presence_of :name, :description
end
