include ApplicationHelper

def sign_in_teacher(teacher)
	visit teacher_sign_in_path
  	fill_in "Email", with: teacher.email
  	fill_in "Password", with: teacher.password
  	click_button "Sign in"
end

def sign_in_student(student)
	visit student_sign_in_path
  	fill_in "Email", with: student.email
  	fill_in "Password", with: student.password
  	click_button "Sign in"
end