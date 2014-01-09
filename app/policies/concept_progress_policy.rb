class ConceptProgressPolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      scope.select do |cp|
        if user.is_a? Teacher
          user.courses.include? cp.enrollment.course and not cp.new_record?
        elsif user.is_a? Student
          cp.enrollment.student_id == user.id
        end
      end
    end
  end

  def edit?
    user and user.courses.include? record.concept.unit.course
  end

  def update?
    teacher_and_concept_progress_in_course?
  end

  def destroy?
    teacher_and_concept_progress_in_course?
  end

  private

  def teacher_and_concept_progress_in_course?
    user and user.is_a? Teacher and
      user.courses.include? record.concept.unit.course
  end
end
