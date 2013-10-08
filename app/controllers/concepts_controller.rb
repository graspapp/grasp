class ConceptsController < ApplicationController
  before_filter :authenticate_user

  def new
    @concept = Concept.new
  end

  def create
    @concept = current_unit.concepts.build(concept_params)
    if @concept.save
      redirect_to root_path
    end
  end

  def show
    @concept = Concept.find(params[:id])
  end

  def concept_params
    params.require(:concept).permit(:description)
  end

  def new_progress
    enrollment = Enrollment.where("student_id = ? AND course_id = ?",
                                  current_student.id, @concept.unit.course.id).first

    progress = ConceptProgress.new(enrollment_id: enrollment.id,
                                          concept_id: @concept.id)  

    redirect_to @concept if progress.save
  end

  def modify_level
    @concept = Concept.find(params[:concept_id])

    if student_signed_in?
    
      enrollment = Enrollment.where("student_id = ? AND course_id = ?",
                                  current_student.id, @concept.unit.course.id).first
                                  
      progress = ConceptProgress.where("concept_id= ? AND
                                  enrollment_id = ?",
                                  @concept.id,enrollment.id).first

      comment = Comment.create(content: params[:comment],
                               commenter_name: current_student.full_name) 
                                                          
    elsif teacher_signed_in?
      
      enrollment = Enrollment.where("student_id = ? AND course_id = ?",
                                  params[:student_id], @concept.unit.course.id).first
                                  
      progress = ConceptProgress.where("concept_id= ? AND
                                    enrollment_id = ?",
                                    @concept.id,enrollment.id).first
    
      comment = Comment.create(content: params[:comment],
                              commenter_name: current_teacher.full_name)  
    end
    
    progress.add_comment(comment)
    progress.change_level(params[:level])
    
    redirect_to @concept if progress.save  
  end
  
  helper_method :new_progress
end

def authenticate_user  
  redirect_to sign_in_path, :flash => { :alert => "You need to sign in or sign up before continuing."} unless student_signed_in? or teacher_signed_in?
end
