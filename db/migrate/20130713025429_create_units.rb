class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.belongs_to :course
      t.string :name
      t.string :number

      t.timestamps
    end
  end
end
