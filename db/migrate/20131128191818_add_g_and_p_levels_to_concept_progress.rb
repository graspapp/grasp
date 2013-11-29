class AddGAndPLevelsToConceptProgress < ActiveRecord::Migration
  def change
    change_table :concept_progresses do |t|
      t.integer :g_level
      t.rename :level, :p_level
    end
  end
end
