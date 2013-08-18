class StudentsController < ApplicationController

  def home
    if params[:id].nil? && current_student
      @student = current_student
    else
      @student = Student.find(params[:id])
    end
  end

  def add_course
    course_code = params[:code]
    courses = Course.all.to_a
    courses.map { |c| current_student.courses << c if course_code == c.code } 
    redirect_to root_path 
  end
end
