class ChangeNextStepsInConceptProgresses < ActiveRecord::Migration
  def change
    change_column :concept_progresses, :next_steps, :string
  end
end
