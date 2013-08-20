class RenameNameToDescriptionInLearningTargets < ActiveRecord::Migration
  def change
    rename_column :learning_targets, :name, :description
  end
end
