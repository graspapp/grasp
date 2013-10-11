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

    if student_signed_in?
      student = current_student
      enrollment = Enrollment.where(student_id: student.id,
                                    course_id: @concept.unit.course_id).first

      @progress = ConceptProgress.where(enrollment_id: enrollment.id,
                                       concept_id: @concept.id).first

      if @progress.nil?
        @progress = ConceptProgress.create(enrollment_id: enrollment.id,
                                           concept_id: @concept.id)
      end
    end
  end

  def concept_params
    params.require(:concept).permit(:description)
  end

  def new_progress
    enrollment = Enrollment.where(student_id: current_student.id,
                                  course_id: @concept.unit.course.id).first

    progress = ConceptProgress.new(enrollment_id: enrollment.id,
                                   concept_id: @concept.id)  

    redirect_to @concept if progress.save
  end

  def modify_concept
    @concept = Concept.find(params[:concept_id])

    if student_signed_in?
    
      enrollment = Enrollment.where(student_id: current_student.id,
                                    course_id: @concept.unit.course.id).first
                                  
      progress = ConceptProgress.where(concept_id: @concept.id,
                                       enrollment_id: enrollment.id).first
    elsif teacher_signed_in?
      
      enrollment = Enrollment.where(student_id: params[:student_id],
                                    course_id: @concept.unit.course.id).first
                                  
      progress = ConceptProgress.where(concept_id: @concept.id,
                                       enrollment_id: enrollment.id).first
    end

    progress.update_attributes(level: params[:level],
                               type_of_error: params[:type_of_error],
                               next_steps: params[:next_steps])
    
    redirect_to @concept if progress.save  
  end

  def concept_progress_for(concept, student)
    course = concept.unit.course
    enrollment = Enrollment.where(student_id: student.id,
                                  course_id: course.id).last

    p ConceptProgress.all

    ConceptProgress.where(enrollment_id: enrollment.id,
                          concept_id: concept.id).last
  end

  helper_method :new_progress
end

def authenticate_user  
  redirect_to sign_in_path, :flash => { :alert => "You need to sign in or sign up before continuing."} unless student_signed_in? or teacher_signed_in?
end
