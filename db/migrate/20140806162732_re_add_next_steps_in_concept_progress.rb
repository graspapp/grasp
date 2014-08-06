class ReAddNextStepsInConceptProgress < ActiveRecord::Migration
  def change
    add_column :concept_progresses, :next_steps, :string
  end
end
