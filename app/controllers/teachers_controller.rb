class TeachersController < ApplicationController

  def home
    if params[:id].nil? && current_teacher
      @teacher = current_teacher
    else
      @teacher = Teacher.find(params[:id])
    end
    
    if signed_in?
      @courses = current_teacher.courses
    end    
  end
  
  def add_unit
    @unit = Unit.new(number: params[:unit_number], name: params[:unit_name], course_id: current_course.id)
    
    if @unit.save
      redirect_to root_path
    end
  end
end