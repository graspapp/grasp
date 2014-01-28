class CreateSteps < ActiveRecord::Migration
  def change
    create_table :steps do |t|
      t.integer :error_type_id
      t.string :description
      t.timestamps
    end
  end
end
