class Unit < ActiveRecord::Base
  belongs_to :course

  validates_presence_of :name, :number
end
