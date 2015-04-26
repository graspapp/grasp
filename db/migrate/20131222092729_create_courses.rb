class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.belongs_to :teacher, index: true
      t.string :name
      t.string :course_code

      t.timestamps, :null => true
    end
  end
end
