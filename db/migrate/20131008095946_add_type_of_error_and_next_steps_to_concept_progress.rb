class AddTypeOfErrorAndNextStepsToConceptProgress < ActiveRecord::Migration
  def change
    add_column :concept_progresses, :type_of_error, :text
    add_column :concept_progresses, :next_steps, :text
  end
end
