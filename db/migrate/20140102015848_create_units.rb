class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.belongs_to :course
      t.string :number
      t.string :name

      t.timestamps, :null => true
    end
  end
end
