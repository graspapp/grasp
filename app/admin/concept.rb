ActiveAdmin.register Concept do
  permit_params :number, :description

  index do
    column :id
    column :number
    column :description
    column :unit, sortable: :unit_number
    default_actions
  end

  filter :number
  filter :description

  sidebar :unit_information, only: :show do
    attributes_table_for concept.unit do
      row("Unit") { auto_link concept.unit }
    end
  end
end
