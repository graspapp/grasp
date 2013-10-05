class Task < ActiveRecord::Base

  belongs_to :concept
  
  validates_presence_of :status, :content
end
