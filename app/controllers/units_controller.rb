class UnitsController < ApplicationController

  before_filter :authenticate_user
  
  def new
    @unit = Unit.new
  end

  def show
    @unit = Unit.find(params[:id])
    @concepts = @unit.concepts.sort_by { |c| [c.number.length, c.number] }

    if student_signed_in?
      create_needed_concept_progresses_for current_student
    end
  end
  
  def destroy
    @unit = Unit.find(params[:id])
    @unit.destroy
    redirect_to root_url
  end
  
  def add_concept
    @concept = Concept.new(unit_id: params[:current_unit], description:
                           params[:concept_desc], number:
                           params[:concept_number])

    @concept.save
      
    redirect_to unit_path(params[:current_unit])
  end

  private
  
  def unit_params
    params.require(:unit).permit(:name)
  end

  def create_needed_concept_progresses_for(student)
    enrollment = Enrollment.where(student_id: student.id,
                                  course_id: @unit.course_id).first

    @unit.concepts.each do |c|
      progress = ConceptProgress.where(enrollment_id: enrollment.id,
                                       concept_id: c.id).first

      if progress.nil?
        ConceptProgress.create(enrollment_id: enrollment.id,
                               concept_id: c.id)
      end
    end
  end

  def concept_progress_for(concept, student)
    course = concept.unit.course
    enrollment = Enrollment.where(student_id: student.id,
                                  course_id: course.id).last

    ConceptProgress.where(enrollment_id: enrollment.id,
                          concept_id: concept.id).last
  end

  helper_method :concept_progress_for
end

def authenticate_user  
  redirect_to sign_in_path,
    :flash => {
      :alert => "You need to sign in or sign up before continuing."
    } unless student_signed_in? or teacher_signed_in?
end
