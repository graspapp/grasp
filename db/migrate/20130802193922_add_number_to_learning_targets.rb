class AddNumberToLearningTargets < ActiveRecord::Migration
  def change
    add_column :learning_targets, :number, :string
  end
end
