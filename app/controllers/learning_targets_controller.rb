class LearningTargetsController < ApplicationController
<<<<<<< HEAD
  def new
    @lt = LearningTarget.new
  end
  
  def create
    @lt = current_unit.learning_targets.build(lt_params)
    if @course.save
      redirect_to root_path
    end
  end
  
  def lt_params
    params.require(:learning_target).permit(:name)
=======

  def level_up
    lt = LearningTarget.find(params[:id])
    lt.level += 1 if lt.level < 4
    lt.save
    render :nothing => true  
>>>>>>> d54196738693c70859e677c8102d73383593b959
  end
end
