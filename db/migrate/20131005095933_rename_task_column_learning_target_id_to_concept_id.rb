class RenameTaskColumnLearningTargetIdToConceptId < ActiveRecord::Migration
  def change
    rename_column :tasks, :learning_target_id, :concept_id
  end
end
