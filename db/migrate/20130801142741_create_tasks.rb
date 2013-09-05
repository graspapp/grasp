class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :status
      t.string :content
      t.integer :learning_target_id

      t.timestamps
    end
  end
end
