class CoursesController < ApplicationController

  def new
    @course = current_teacher.courses.new
  end
  
  def create
    @course = current_teacher.courses.build(course_params)
    if @course.save
      redirect_to root_path
    end
    
  end
  
  def course_params
    params.require(:course).permit(:name)
  end
end
