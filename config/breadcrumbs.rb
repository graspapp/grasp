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
  link "Concept #{ concept.number }", concept_path(concept)
  parent :unit, concept.unit
end
