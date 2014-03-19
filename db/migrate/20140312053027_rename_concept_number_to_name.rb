class RenameConceptNumberToName < ActiveRecord::Migration
  def change
    rename_column :concepts, :number, :name
  end
end
