class Concept < ActiveRecord::Base
  belongs_to :unit

  validates_presence_of :number, :description
end
