class Concept < ActiveRecord::Base
  belongs_to :unit
  default_scope -> { order('created_at ASC') }
  has_many :concept_progresses, dependent: :destroy

  validates_presence_of :name, :description
end
