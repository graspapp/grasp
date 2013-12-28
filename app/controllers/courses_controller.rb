class CoursesController < ApplicationController
  def new
    @course = Course.new
    authorize @course
  end

  def show
    @course = Course.find(params[:id])
    authorize @course
  end

  def create
    @course = current_user.courses.build(course_params)
    authorize @course
    if @course.save
      redirect_to root_path
    else
      render "new"
    end
  end

  def edit
    @course = Course.find(params[:id])
    authorize @course
  end

  def update
    @course = Course.find(params[:id])
    authorize @course
    if @course.update_attributes(course_params)
      flash[:success] = "Course updated"
      redirect_to @course
    else
      render "edit"
    end
  end

  def destroy
    @course = Course.find(params[:id])
    authorize @course
    @course.destroy
    flash[:success] = "Course destroyed."
    redirect_to root_url
  end

  private

  def course_params
    params.require(:course).permit(:name)
  end
end
