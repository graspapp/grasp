class UnitPolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      scope.select { |u| user.courses.include? u.course and not u.new_record? }
    end
  end

  def show?
    user and user.courses.include? record.course
  end

  def create?
    teacher_and_unit_in_course?
  end

  def edit?
    teacher_and_unit_in_course?
  end

  def update?
    teacher_and_unit_in_course?
  end

  def destroy?
    teacher_and_unit_in_course?
  end

  private

  def teacher_and_unit_in_course?
    user and user.is_a? Teacher and user.courses.include? record.course
  end
end
