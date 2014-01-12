class CoursesController < ApplicationController
  before_action :find_and_authorize_course, except: :create

  def create
    @course = current_user.courses.build(course_params)
    authorize @course
    if @course.save
      redirect_to root_path
    else
      flash[:alert] = @course.errors.full_messages.to_sentence
      redirect_to (request.referer.present? ? :back : root_path)
    end
  end

  def show
    @units = @course.units
    @unit = @units.build
  end

  def edit
  end

  def update
    if @course.update_attributes(course_params)
      flash[:success] = "Course updated"
      redirect_to root_path
    else
      render "edit"
    end
  end

  def destroy
    @course.destroy
    flash[:success] = "Course destroyed."
    redirect_to root_url
  end

  private

  def course_params
    params.require(:course).permit(:name)
  end

  def find_and_authorize_course
    @course = Course.find(params[:id])
    authorize @course
  end
end
