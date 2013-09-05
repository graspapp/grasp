class AddLevelColumnToLearningTargets < ActiveRecord::Migration
  def change
    add_column :learning_targets, :level, :integer
  end
end
