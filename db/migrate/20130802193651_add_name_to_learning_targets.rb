class AddNameToLearningTargets < ActiveRecord::Migration
  def change
    add_column :learning_targets, :name, :string
  end
end
