class RenameGLevelToMasteryLevel < ActiveRecord::Migration
  def change
    rename_column :concept_progresses, :g_level, :mastery_level
  end
end
