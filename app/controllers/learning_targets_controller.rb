class LearningTargetsController < ApplicationController

  def level_up
    lt = LearningTarget.find(params[:id])
    lt.level += 1 if lt.level < 4
    lt.save
    render :nothing => true  
  end
end
