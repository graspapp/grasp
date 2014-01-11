ActiveAdmin.register Course do
  permit_params :name, :course_code

  index do
    column :id
    column :name
    column :course_code
    column :teacher, sortable: :teacher_id
    default_actions
  end

  filter :name

  sidebar :teacher_information, only: :show do
    attributes_table_for course.teacher do
      row("Teacher") { auto_link course.teacher }
      row :first_name
      row :last_name
    end
  end
end
