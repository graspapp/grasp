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
  
  def goals
    @goals = { 
      1 => "1: Misconception errors (A, C, M), major reasoning and procedural
            errors (C, E, M)",
      2 =>  "2: Minimal/Minor conceptual errors (E, M), reasoning errors (C, M),
             procedural errors (E, M)",     
      3 =>  "3: No conceptual errors (A, C, M), logical reasoning with minor
             errors (C, M), minor procedural errors (E, M)",
      4 =>  "4: No conceptual errors (A, C, M) logical and accurate reasoning
             (C, M), minimal and minor procedural errors (E, M)"}
      @goals.sort.map {|k,v| [v,k]}
  end
  
  def mastery
    @mastery = @goals.merge(-1 => "NY (not yet): Major misconception
     (A), incorrect reasoning, incorrect procedures (C, E, M)", 
     
     0 => "0: No work. Not thinking. Blank..."
     
     )
    @mastery.sort.map {|k,v| [v,k]}
  end
  
  def errors
    @errors = { 
      "Procedural" => "Procedural: Found when attending to precision (E), using 
                  tools strategically (A, C, E), and in repeated reasoning (M)",
      "Conceptual" => "Conceptual: Found in my Approach/Analysis (A) when making
              sense of the problem and reasoning abstractly/quantitatively
              (M)",  
      "Misconception" => "Misconception: Found when making sense of the problem
                           (A) and reasoning abstractly/quantitatively (M)",
      "Reasoning" =>  "Reasoning: Found when looking for structure (C), finding
                       a model or constructing a viable argument (C)",
      "No Error" => "No Error"}
  
      @errors.map {|k,v| [v,k]}
  end
  
  helper_method :goals, :mastery, :errors
  
  private

  def concept_progress_params
    params.require(:concept_progress).permit(:type_of_error, :next_steps,
                                             :mastery_level, :goal_level,
                                             :action_steps, :completed,
                                             :leveling_up)
  end

  def find_and_authorize_concept_progress
    @concept_progress = ConceptProgress.find(params[:id])
    authorize @concept_progress
  end
end
