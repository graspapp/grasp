class LearningTarget < ActiveRecord::Base

  belongs_to :unit
  has_many :tasks, dependent: :destroy
  
  validates_presence_of :name, :number
end
