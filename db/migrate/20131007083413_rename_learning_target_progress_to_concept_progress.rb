class RenameLearningTargetProgressToConceptProgress < ActiveRecord::Migration
  def change
    rename_table :learning_target_progresses, :concept_progresses

    rename_column :comments, :learning_target_progress_id, :concept_progress_id
    rename_column :concepts, :learning_target_progress_id, :concept_progress_id
  end
end
