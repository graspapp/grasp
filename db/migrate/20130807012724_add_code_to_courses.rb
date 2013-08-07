class AddCodeToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :code, :string
  end
end
