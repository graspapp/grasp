class AddFeedbackToConceptProgresses < ActiveRecord::Migration
  def change
    add_column :concept_progresses, :feedback, :string
  end
end
