class Course < ActiveRecord::Base

  belongs_to :teacher
  has_many :units

  validates_presence_of :name
end
