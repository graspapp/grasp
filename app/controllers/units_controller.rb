class UnitsController < ApplicationController
  before_action :find_and_authorize_unit, except: :create

  def create
    @course = Course.find(params[:unit][:course_id])
    @unit = @course.units.build(unit_params)
    authorize @unit
    if @unit.save
      redirect_to @course
    else
      flash[:alert] = @unit.errors.full_messages.to_sentence
      redirect_to (request.referer.present? ? :back : root_path)
    end
  end

  def show
    @concepts = @unit.concepts
    @concept = @concepts.build
  end

  def edit
  end

  def update
    if @unit.update_attributes(unit_params)
      flash[:success] = "Unit updated"
      redirect_to @unit.course
    else
      render "edit"
    end
  end

  def destroy
    @course = @unit.course
    @unit.destroy
    flash[:success] = "Unit destroyed."
    redirect_to @course
  end

  private

  def unit_params
    params.require(:unit).permit(:name, :number)
  end

  def find_and_authorize_unit
    @unit = Unit.find(params[:id])
    authorize @unit
  end
end
