class Unit < ActiveRecord::Base

  belongs_to :course
  has_many :learning_targets

  validates_presence_of :name, :number
end
