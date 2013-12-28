class CoursePolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
      if user.is_a? Teacher
        scope.where(teacher_id: user.id)
      elsif user.is_a? Student
        scope.where(enrollments: { student_id: user.id })
      end
    end
  end

  def new?
    user.is_a? Teacher
  end

  def show?
    user and user.courses.include? record
  end

  def create?
    teacher_and_has_course?
  end

  def edit?
    teacher_and_has_course?
  end

  def update?
    teacher_and_has_course?
  end

  def destroy?
    teacher_and_has_course?
  end

  private

  def teacher_and_has_course?
    user and user.is_a?(Teacher) and user.courses.include?(record)
  end
end
