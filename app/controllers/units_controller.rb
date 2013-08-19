class UnitsController < ApplicationController

  def new
    @unit = Unit.new
  end
  
  def unit_params
    params.require(:unit).permit(:name)
  end
end
