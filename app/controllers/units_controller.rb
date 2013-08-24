 class UnitsController < ApplicationController

  def new
    @unit = Unit.new
  end

  def show
    @unit = Unit.find(params[:id])
  end
  
  def add_lt
    @lt = LearningTarget.new(unit_id: params[:current_unit], description: params[:lt_desc], number: params[:lt_number])

    @lt.save
      
    redirect_to unit_path(params[:current_unit])
  end
  
  def unit_params
    params.require(:unit).permit(:name)
  end
end
