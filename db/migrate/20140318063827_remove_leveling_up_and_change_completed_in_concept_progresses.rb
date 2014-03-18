class RemoveLevelingUpAndChangeCompletedInConceptProgresses < ActiveRecord::Migration
  def change
    change_table :concept_progresses do |t|
      t.remove :leveling_up
      t.change :completed, :string
    end
  end
end
