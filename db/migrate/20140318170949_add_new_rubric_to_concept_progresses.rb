class AddNewRubricToConceptProgresses < ActiveRecord::Migration
  def change
    add_column :concept_progresses, :effort, :integer
    add_column :concept_progresses, :note_taking, :integer
    add_column :concept_progresses, :studying, :integer
  end
end
