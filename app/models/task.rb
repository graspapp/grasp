class Task < ActiveRecord::Base

  belongs_to :learning_target
  
  validates_presence_of :status, :content
end
