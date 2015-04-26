class CreateConceptProgresses < ActiveRecord::Migration
  def change
    create_table :concept_progresses do |t|
      t.references :enrollment, index: true
      t.references :concept, index: true
      t.integer :p_level
      t.integer :g_level
      t.string :type_of_error
      t.text :next_steps

      t.timestamps null: false
    end
  end
end
