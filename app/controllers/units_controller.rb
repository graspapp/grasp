class UnitsController < ApplicationController

  def new
    @unit = Unit.new
  end

  def show
    @unit = Unit.find(params[:id])
  end
  
  def add_concept
    @concept = Concept.new(unit_id: params[:current_unit], description: params[:concept_desc], number: params[:concept_number])

    @concept.save
      
    redirect_to unit_path(params[:current_unit])
  end
  
  def unit_params
    params.require(:unit).permit(:name)
  end
end
