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
    s = current_student

    exists = courses.any? { |c| c.code == course_code }
    already_added = s.courses.any? { |c| c.code == course_code } and exists

    unless already_added
      courses.map { |c| s.courses << c if course_code == c.code } 
    end

    flash.alert = 'Course does not exist.' unless exists
    flash.alert = 'Course is already added.' if already_added

    redirect_to root_path 
  end
end
