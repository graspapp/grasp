class CreateLearningTargetProgresses < ActiveRecord::Migration
  def change
    create_table :learning_target_progresses do |t|

      t.timestamps
      t.belongs_to :enrollment
      t.integer    :learning_target_id
      t.integer    :level
    end
  end
end
