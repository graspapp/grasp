class RenameLevelIdInSteps < ActiveRecord::Migration
  def change
    rename_column :steps, :level_id, :error_type_id
  end
end
