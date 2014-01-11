class ConceptsController < ApplicationController
  def create
    @unit = Unit.find(params[:concept][:unit_id])
    @concept = @unit.concepts.build(concept_params)
    authorize @concept
    if @concept.save
      redirect_to @unit
    else
      flash[:alert] = @concept.errors.full_messages.to_sentence
      redirect_to (request.referer.present? ? :back : @unit)
    end
  end

  def show
    @concept = Concept.find(params[:id])
    @concept_progresses = @concept.concept_progresses
    authorize @concept

    if current_user.is_a? Student
      enrollment = Enrollment.find_by(course: @concept.unit.course,
                                      student: current_user)
      
      if enrollment.concept_progresses.find_by(concept: @concept).nil?
        @concept_progress = ConceptProgress.create

        enrollment.concept_progresses << @concept_progress
        @concept.concept_progresses << @concept_progress
      end
    end
  end

  def edit
    @concept = Concept.find(params[:id])
    authorize @concept
  end

  def update
    @concept = Concept.find(params[:id])
    authorize @concept
    if @concept.update_attributes(concept_params)
      flash[:success] = "Concept updated"
      redirect_to @concept.unit
    else
      render "edit"
    end
  end

  def destroy
    @concept = Concept.find(params[:id])
    @unit = @concept.unit
    authorize @concept
    @concept.destroy
    flash[:success] = "Concept successfully deleted."
    redirect_to @unit
  end

  private

  def concept_params
    params.require(:concept).permit(:number, :description)
  end
end
