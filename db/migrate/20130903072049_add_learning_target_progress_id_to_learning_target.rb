class AddLearningTargetProgressIdToLearningTarget < ActiveRecord::Migration
  def change
    add_column :learning_targets, :learning_target_progress_id, :integer
  end
end
