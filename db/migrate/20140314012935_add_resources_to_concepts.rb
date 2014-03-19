class AddResourcesToConcepts < ActiveRecord::Migration
  def change
    add_column :concepts, :resources, :text
  end
end
