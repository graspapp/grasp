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
  
  def new_progress
    enrollment = Enrollment.where("student_id = ? AND course_id = ?", current_student.id, @lt.unit.course.id).first
   progress = LearningTargetProgress.new(enrollment_id: enrollment.id, learning_target_id: params[:id], level: 1)  
   
   if progress.save
     redirect_to learning_target_path(params[:id])
   end
  end
  
  
  
  helper_method :new_progress
end
