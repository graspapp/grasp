class DeleteTeacherAndStudentTables < ActiveRecord::Migration
  def change
    drop_table :teachers
    drop_table :students
  end
end
