class CoursesController < ApplicationController
  def new
    @course = Course.new
  end

  def show
    @course = Course.find(params[:id])
  end

  def create
    @course = Course.
  end

  private

  def course_params
    params.require(:course).permit(:name)
  end
end
