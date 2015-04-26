class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|

      t.timestamps, :null => true
    end
  end
end
