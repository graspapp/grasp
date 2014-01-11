module UsersHelper
  def full_name(user)
    "#{ user.first_name } #{ user.last_name }"
  end

  def show_course_actions?(user)
    user.courses.map { |c|
      policy(c).edit? or policy(c).destroy?
    }.any?
  end
end
