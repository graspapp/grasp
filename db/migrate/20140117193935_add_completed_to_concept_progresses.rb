class AddCompletedToConceptProgresses < ActiveRecord::Migration
  def change
    add_column :concept_progresses, :completed, :boolean
  end
end
