class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :school
      t.string :state
      t.string :country
      t.timestamps
    end
  end
end
