class LearningTarget < ActiveRecord::Base

  MAX_LEVEL = 4

  after_initialize :init

  belongs_to :unit
  has_many :tasks, dependent: :destroy

  validates_presence_of :description, :number, :level

  def init
    self.level ||= 1
  end
end
