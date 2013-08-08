class TeachersController < ApplicationController
  def home
  	if params[:id].nil? && current_teacher
      @teacher = current_teacher
    else
      @teacher = Teacher.find(params[:id])
    end
    
    if signed_in?
      @courses = current_teacher.courses
      @course = current_teacher.courses.build  
    end    
  end

end