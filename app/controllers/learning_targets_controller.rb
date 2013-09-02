class LearningTargetsController < ApplicationController
  def new
    @lt = LearningTarget.new
  end
  
  def create
    @lt = current_unit.learning_targets.build(lt_params)
    if @lt.save
      redirect_to root_path
    end
  end
  
  def show
    @lt = LearningTarget.find(params[:id])
  end
  
  def lt_params
    params.require(:learning_target).permit(:description)
  end
  
  def has_progress?
  end
end
