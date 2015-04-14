class LearningTool < ActiveRecord::Base

  def generate_filepath
    "#{Rails.root}/public/learning_tools/#{self.category_number}/#{self.filename}"
  end
end
