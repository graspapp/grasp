module ConceptProgressesHelper
  def goals
    @goals = { 
      1 => "1: Misconception errors (A), major reasoning and procedural
            errors (C, E, M)",
      2 => "2: No conceptual errors (A), reasoning errors (C,M), procedural 
            errors (E)",     
      3 =>  "3: No conceptual errors (A), logical reasoning with minor errors 
            (C, M), minor procedural errors (E)",
      4 =>   "4: No conceptual errors (A) logical and accurate reasoning (C, M),  
              minimal and minor procedural errors (E)"}
      @goals.sort.map {|k,v| [v,k]}
  end
  
  def mastery
    @mastery = @goals.merge(0 => "NY (not yet): Major misconception (A),incorrect 
    reasoning, incorrect procedures (C, E, M)" )
    
    @mastery.sort.map {|k,v| [v,k]}
  end
  
  def errors
    @errors = { 
      "Procedural" => "Procedural: Found when attending to precision (E), using 
                  tools strategically (A, C, E), and in repeated reasoning (M)",
      "Conceptual" => "Conceptual: Found in my Approach/Analysis (A) when making
              sense of the problem and reasoning abstractly/quantitatively (M)",  
      "Misconception" => "Misconception: Found when making sense of the problem
                           (A) and reasoning abstractly/quantitatively (M)",
      "Reasoning" =>  "Reasoning: Found when looking for structure (C), finding
                       a model or constructing a viable argument (C)",
      "No Error" => "No Error"}
  
      @errors.map {|k,v| [v,k]}
  end
end
