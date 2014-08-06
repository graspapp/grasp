class ChangeResourcesInConcepts < ActiveRecord::Migration
  def change
    rename_column :concepts, :resources, :dok1_resources
    add_column :concepts, :dok2_resources, :text
    add_column :concepts, :dok3_resources, :text
  end
end
