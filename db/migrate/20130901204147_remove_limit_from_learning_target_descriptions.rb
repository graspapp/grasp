class RemoveLimitFromLearningTargetDescriptions < ActiveRecord::Migration
  def up
    change_column :learning_targets, :description, :text, :limit => nil
  end
  def down
    change_column :learning_targets, :description, :text, :limit => 255
  end
end
