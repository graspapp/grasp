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
    authorize @concept
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
