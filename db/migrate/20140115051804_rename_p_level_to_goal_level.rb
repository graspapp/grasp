class RenamePLevelToGoalLevel < ActiveRecord::Migration
  def change
    rename_column :concept_progresses, :p_level, :goal_level
  end
end
