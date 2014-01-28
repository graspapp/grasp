class AddActionStepsToConceptProgresses < ActiveRecord::Migration
  def change
    add_column :concept_progresses, :action_steps, :text
  end
end
