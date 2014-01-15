class CoursePolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      scope.select { |c| user.courses.include? c and not c.new_record? }
    end
  end

  def show?
    user and user.courses.include? record
  end

  def create?
    teacher_and_has_course?
  end

  def edit?
    update?
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
