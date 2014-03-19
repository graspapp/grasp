module ConceptsHelper
  def concept_title(concept)
    "Concept #{ concept.name }"
  end

  def show_concept_progress_actions?(concept)
    concept.concept_progresses.map { |cp|
      policy(cp).edit?
    }.any?
  end
end
