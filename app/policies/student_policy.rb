class StudentPolicy < ApplicationPolicy
  def add_course?
    record == user
  end

  def leave_course?
    record == user
  end
end
