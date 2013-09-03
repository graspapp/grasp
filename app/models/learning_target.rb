class LearningTarget < ActiveRecord::Base

  belongs_to :unit
  has_many :learning_target_progresses, dependent: :destroy
  has_many :tasks, dependent: :destroy

  validates_presence_of :description, :number
end
