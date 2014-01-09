class ConceptProgressesController < ApplicationController
  def edit
    @concept_progress = ConceptProgress.find(params[:id])
    authorize @concept_progress
  end

  def update
    @concept_progress = ConceptProgress.find(params[:id])
    authorize @concept_progress
    if @concept_progress.update_attributes(concept_progress_params)
      redirect_to @concept_progress.concept
    else
      render :edit
    end
  end

  private

  def concept_progress_params
    params.require(:concept_progress).permit(:type_of_error, :next_steps,
                                             :master_level, :p_level)
  end
end
