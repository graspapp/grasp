class UseTextForLearningTargetDescriptions < ActiveRecord::Migration
  def up
    change_column :learning_targets, :description, :text
  end
  def down
    change_column :learning_targets, :description, :string
  end
end
