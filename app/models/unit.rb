class Unit < ActiveRecord::Base

  belongs_to :course
  has_many :concepts

  validates_presence_of :name, :number
end
