ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Recent Students" do
          table_for Student.last(5) do |s|
            column(:email) { |s| link_to(s.email, admin_student_path(s)) }
          end
        end
      end
      
      column do
        panel "Recent Teachers" do
          table_for Teacher.last(5) do |t|
            column(:email) { |t| link_to(t.email, admin_teacher_path(t)) }
          end
        end
      end
    end
  end
end
