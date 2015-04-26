class CreateConcepts < ActiveRecord::Migration
  def change
    create_table :concepts do |t|
      t.references :unit, index: true
      t.string :number
      t.text :description

      t.timestamps null: false
    end
  end
end
