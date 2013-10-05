class RenameLearningTargetToConcept < ActiveRecord::Migration
  def change
    rename_table :learning_targets, :concepts
  end
end
