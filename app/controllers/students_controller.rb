class StudentsController < ApplicationController

  def home
    if params[:id].nil? && current_student
      @student = current_student
    else
      @student = Student.find(params[:id])
    end
  end
end
