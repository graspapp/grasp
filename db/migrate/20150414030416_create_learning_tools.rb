class CreateLearningTools < ActiveRecord::Migration
  def change
    create_table :learning_tools do |t|

      t.string :title, null: :false, default: ''
      t.string :description, null: :false, default: ''
      t.string :filename, null: false, default: ''
      t.integer :category_number, null: :false, default: 1
      t.timestamps
    end
  end
end
