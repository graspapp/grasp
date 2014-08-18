class CreateMasteries < ActiveRecord::Migration
  def change
    create_table :masteries do |t|
      t.integer :value
      t.string :description
      t.timestamps
    end
  end
end
