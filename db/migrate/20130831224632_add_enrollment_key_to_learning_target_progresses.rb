class AddEnrollmentKeyToLearningTargetProgresses < ActiveRecord::Migration
  def change
    add_column :learning_target_progresses, :enrollment_id, :integer
  end
end
