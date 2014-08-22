crumb :root do
  link "Home", root_path
end

crumb :course do |course|
  link course.name, course_path(course)
end

crumb :unit do |unit|
  link unit.name, unit_path(unit)
  parent :course, unit.course
end

crumb :concept do |concept|
  link "#{ concept.name }", concept_path(concept)
  parent :unit, concept.unit
end

crumb :concept_progress do |concept_progress|
  link "#{ full_name(concept_progress.enrollment.student)}",
    concept_progress_path(concept_progress)
    parent :concept, concept_progress.concept
end
