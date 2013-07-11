class Course < ActiveRecord::Base

  belongs_to :teacher
  validates_presence_of :name
end
