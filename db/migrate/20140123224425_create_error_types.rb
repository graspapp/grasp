class CreateErrorTypes < ActiveRecord::Migration
  def change
    create_table :error_types do |t|
      t.string :error_type
      t.string :description
      t.timestamps
    end
  end
end
