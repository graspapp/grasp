class AddLevelingUpToConceptProgresses < ActiveRecord::Migration
  def change
    add_column :concept_progresses, :leveling_up, :boolean
  end
end
