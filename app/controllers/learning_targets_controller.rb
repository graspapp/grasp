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
  
  # TODO: Fix this
  def lt_params
    params.require(:learning_target).permit(:name)
  end

  # TODO: Remove this
  def level_up
    lt = LearningTarget.find(params[:id])
    lt.level += 1 if lt.level < 4
    lt.save
    render :nothing => true  
  end
end
