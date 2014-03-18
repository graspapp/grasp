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
      1 => "1: Misconception errors (A), major reasoning and procedural errors
            (C, E, M)",
      2 =>  "2: Minimal/minor conceptual errors (E), reasoning errors (C,M),
             procedural errors (E)",     
      3 =>  "3: No conceptual errors (A), logical reasoning with minor errors
           (C, M), minor procedural errors and possible calculation errors (E)",
      4 =>  "4: No conceptual errors (A) logical and accurate reasoning (C, M),
             minimal and minor calculation errors and no procedural errors (E)"}
      @goals.sort.map {|k,v| [v,k]}
  end
  
  def mastery
    @mastery = @goals.merge(-1 => "NY (not yet): Major misconception (A),
                     incorrect reasoning, incorrect procedures (C, E, M)", 
     
     0 => "N (No response): Conference with student/parent"
     
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
  
  def effort
    @effort = { 
      1 => "1: I do not ask questions and I rarely complete the minimum work
            required within the recommended time frame.",
      2 =>  "2: I ask procedural questions and I sometimes complete the minimum
             work required within the recommended time frame.",     
      3 =>  "3: I ask questions when I get stuck and I push myself to exceed
             the minimum work required. ",
      4 =>  "4: I am always asking questions and I push myself to understand
             the material deeply."}
    @effort.sort.map {|k,v| [v,k]}
  end
  
  def note_taking
    @note_taking = { 
      1 => "1: I cannot understand my notes, so I do not use them as a
            reference.",
      2 =>  "2: I sometimes take notes and rarely refer to them.",     
      3 =>  "3: I take notes and refer to them when prompted.",
      4 =>  "4: I take comprehensive notes and refer to them, as needed, when
             doing classwork/homework."}
    @note_taking.sort.map {|k,v| [v,k]}
  end
  
  def study
    @study = { 
      1 => "1: I study for the test the night before only. I study class notes
            sometimes and do not attempt practice problems.",
      2 =>  "2: I begin studying for a test 2 days before the test. I study
            class notes for 5-10 minutes each day, and do not attempt practice
            problems.",     
      3 =>  "3: I begin studying for a test 3-5 days before the test. I study
             class notes for 5-10 minutes per day every day until the test, and
             attempt 1-2 practice problems.",
      4 =>  "4: I begin studying for a test as soon as it is announced. I study
             class notes for 10 minutes per day every day until the test, and
             attempt 2-3 practice problems."}
    @study.sort.map {|k,v| [v,k]}
  end
  
  helper_method :goals, :mastery, :errors, :effort, :note_taking, :study
  
  private

  def concept_progress_params
    params.require(:concept_progress).permit(:type_of_error, :next_steps,
                                             :mastery_level, :goal_level,
                                             :effort, :note_taking, :studying,
                                             :action_steps, :completed,
                                             :leveling_up, :feedback)
  end

  def find_and_authorize_concept_progress
    @concept_progress = ConceptProgress.find(params[:id])
    authorize @concept_progress
  end
end
