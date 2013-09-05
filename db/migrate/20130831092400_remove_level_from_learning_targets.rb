class RemoveLevelFromLearningTargets < ActiveRecord::Migration
  def change
    remove_column :learning_targets, :level, :integer
  end
end
