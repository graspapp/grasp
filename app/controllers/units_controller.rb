class UnitsController < ApplicationController

  def create
    @unit = current_teacher.units.build(unit_params)
    if @unit.save
      redirect_to root_path
    end
  end
  
  def unit_params
    params.require(:unit).permit(:name)
  end
end
