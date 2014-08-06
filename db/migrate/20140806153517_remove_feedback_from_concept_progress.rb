class RemoveFeedbackFromConceptProgress < ActiveRecord::Migration
  def change
    remove_column :concept_progresses, :feedback, :string
    remove_column :concept_progresses, :completed, :string
  end
end
