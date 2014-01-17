class StudentsController < ApplicationController
  def home
    @student = current_user
  end

  def add_course
    student = Student.find(params[:id])
    course_code = params[:course][:course_code]
    authorize student
    course = Course.where(course_code: course_code).first
    if course.nil?
      flash[:alert] = "No courses were found with the specified course code."
    elsif student.courses.include? course
      flash[:alert] = "The specified course is already added."
    else
      student.courses << course
    end
    redirect_to root_path
  end

  def leave_course
    student = Student.find(params[:id])
    authorize student
    unless student.nil? or params[:course][:id].nil? or
      Course.find(params[:course][:id]).nil?

      course = Course.find(params[:course][:id])
      student.courses.delete(course)
    else
      flash[:alert] = "An error occured while trying to delete the course."
    end
    redirect_to root_path
  end
end
