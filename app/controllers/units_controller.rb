class UnitsController < ApplicationController
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
    @unit = Unit.find(params[:id])
    @concepts = @unit.concepts
    @concept = @concepts.build
    authorize @unit
  end

  def edit
    @unit = Unit.find(params[:id])
    authorize @unit
  end

  def update
    @unit = Unit.find(params[:id])
    authorize @unit
    if @unit.update_attributes(unit_params)
      flash[:success] = "Unit updated"
      redirect_to @unit.course
    else
      render "edit"
    end
  end

  def destroy
    @unit = Unit.find(params[:id])
    @course = @unit.course
    authorize @unit
    @unit.destroy
    flash[:success] = "Unit destroyed."
    redirect_to @course
  end

  private

  def unit_params
    params.require(:unit).permit(:name, :number)
  end
end
