class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string     :content
      t.string     :commenter_name
      t.belongs_to :learning_target_progress

      t.timestamps
    end
    add_index :comments, [:created_at]
  end
end
