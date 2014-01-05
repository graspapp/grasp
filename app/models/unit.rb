class Unit < ActiveRecord::Base
  belongs_to :course
  has_many :concepts, dependent: :destroy

  validates_presence_of :name, :number
end
