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
    enrollment = Enrollment.where("student_id = ? AND course_id = ?",
                                  current_student.id, @lt.unit.course.id).first

    progress = LearningTargetProgress.new(enrollment_id: enrollment.id,
                                          learning_target_id: @lt.id)  

    redirect_to @lt if progress.save
  end

  def modify_level
    @lt = LearningTarget.find(params[:lt_id])

    if student_signed_in?
    
      enrollment = Enrollment.where("student_id = ? AND course_id = ?",
                                  current_student.id, @lt.unit.course.id).first
                                  
      progress = LearningTargetProgress.where("learning_target_id = ? AND
                                  enrollment_id = ?",
                                  @lt.id,enrollment.id).first
    elsif teacher_signed_in?
      
      enrollment = Enrollment.where("student_id = ? AND course_id = ?",
                                  params[:student_id], @lt.unit.course.id).first
                                  
      progress = LearningTargetProgress.where("learning_target_id = ? AND
                                    enrollment_id = ?",
                                    @lt.id,enrollment.id).first
      
    end

    progress.change_level(params[:level])
    
    redirect_to @lt if progress.save  
  end
  
  helper_method :new_progress
end
