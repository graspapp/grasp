class LearningTargetsController < ApplicationController
  def new
    @lt = LearningTarget.new
  end
  
  def create
    @lt = current_unit.learning_targets.build(lt_params)
    if @course.save
      redirect_to root_path
    end
  end
  
  def show
    @lt = LearningTarget.find(params[:id])
  end
  
  def lt_params
    params.require(:learning_target).permit(:description)
  end
end
