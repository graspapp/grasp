class RemoveClassCodeFromStudents < ActiveRecord::Migration
  def change
    remove_column :students, :class_code, :string
  end
end
