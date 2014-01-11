ActiveAdmin.register Unit do
  permit_params :number, :name

  index do
    column :id
    column :number
    column :name
    column :course, sortable: :unit_course
    default_actions
  end

  filter :number
  filter :name

  sidebar :unit_information, only: :show do
    attributes_table_for unit.course do
      row("Course") { auto_link unit.course }
      row("Teacher") { auto_link unit.course.teacher }
    end
  end
end
