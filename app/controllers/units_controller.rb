class UnitsController < ApplicationController

  def new
    @unit = Unit.new
  end

  def show
    @unit = Unit.find(params[:id])
  end
  
  def unit_params
    params.require(:unit).permit(:name)
  end
end
