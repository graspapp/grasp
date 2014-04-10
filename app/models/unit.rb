class Unit < ActiveRecord::Base
  belongs_to :course
  has_many :concepts, dependent: :destroy
  default_scope -> { order('number ASC') }
  
  validates_presence_of :name, :number
end
