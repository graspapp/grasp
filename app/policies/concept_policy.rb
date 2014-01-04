class ConceptPolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      scope.select { |c| user.courses.include? c.unit.course }
    end
  end

  def show?
    user and user.courses.include? record.unit.course
  end

  def create?
    teacher_and_concept_in_course?
  end

  def edit?
    teacher_and_concept_in_course?
  end

  def update?
    teacher_and_concept_in_course?
  end

  def destroy?
    teacher_and_concept_in_course?
  end

  private

  def teacher_and_concept_in_course?
    user and user.is_a? Teacher and user.courses.include? record.unit.course
  end
end
