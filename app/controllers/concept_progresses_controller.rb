class ConceptProgressesController < ApplicationController
  before_action :find_and_authorize_concept_progress

  def edit
  end

  def update
    if @concept_progress.update_attributes(concept_progress_params)
      redirect_to @concept_progress.concept
    else
      render :edit
    end
  end

  private

  def concept_progress_params
    params.require(:concept_progress).permit(:type_of_error, :next_steps,
                                             :mastery_level, :goal_level)
  end

  def find_and_authorize_concept_progress
    @concept_progress = ConceptProgress.find(params[:id])
    authorize @concept_progress
  end
end
