class Comment < ActiveRecord::Base
  
  belongs_to :concept_progress
  
  validates_presence_of :content
  validates_presence_of :commenter_name
end
