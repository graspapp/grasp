module ConceptProgressesHelper
  def short_term_goal_explanation
    "After baseline quick check, set a goal for understanding this
     concept to be accomplished in one week."
  end
  
  def mastery_goal_explanation
    "After a recent scored assessment, track your mastery level approved by the
     teacher."
  end
   
  def note_explanation
    "What actions will improve your GRASP?"
  end
  
  def get_student(progress)
    full_name(progress.enrollment.student)
  end
end
