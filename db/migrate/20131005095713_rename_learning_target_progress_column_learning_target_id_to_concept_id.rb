class RenameLearningTargetProgressColumnLearningTargetIdToConceptId < ActiveRecord::Migration
  def change
    rename_column :learning_target_progresses, :learning_target_id, :concept_id
  end
end
