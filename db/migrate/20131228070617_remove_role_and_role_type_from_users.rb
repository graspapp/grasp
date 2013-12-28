class RemoveRoleAndRoleTypeFromUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.remove :role_id
      t.remove :role_type
    end
  end
end
