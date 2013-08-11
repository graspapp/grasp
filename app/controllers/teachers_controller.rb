class TeachersController < ApplicationController

  def home
    if params[:id].nil? && current_teacher
      @teacher = current_teacher
    else
      @teacher = Teacher.find(params[:id])
    end
  end
end
